class Dartsim < Formula
  desc "Dynamic Animation and Robotics Toolkit"
  homepage "https://dartsim.github.io/"
  url "https://github.com/dartsim/dart/archive/refs/tags/v6.14.0.tar.gz"
  sha256 "f3fdccb2781d6a606c031f11d6b1fdf5278708c6787e3ab9a67385d9a19a60ea"
  license "BSD-2-Clause"

  bottle do
    sha256                               arm64_sonoma:   "d482ac5d4fced6f80b4161342f6532fd736fdbc2ba536d03d108205597fe16f0"
    sha256                               arm64_ventura:  "a0513f294b6cf7c55f3d63759dfa80bec77805ca1fdf042260802480ed2d0236"
    sha256                               arm64_monterey: "f26c5f3a861b4190de9a4102e23cd1686ee3b692d05c8cc19a9c8cac42beaa6b"
    sha256                               sonoma:         "7b0f35fe2ccab08976cdd40edfbc97182a9c425f1c48077d3403dfcddfdd9c10"
    sha256                               ventura:        "8d0ded6d56feef80c7e4a53f154a25763b84033f45d43fdc1383ada312857567"
    sha256                               monterey:       "1f80d49484d33b85afaeda38cc8c3bd0af56776ca982c79748e11d77ce72d507"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "15e014a208567544b13b1056c671ad76ae9447f55035cba12a27404bfea0c7d3"
  end

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "pkg-config" => :build

  depends_on "assimp"
  depends_on "bullet"
  depends_on "eigen"
  depends_on "fcl"
  depends_on "flann"
  depends_on "fmt"
  depends_on "ipopt"
  depends_on "libccd"
  depends_on "nlopt"
  depends_on "ode"
  depends_on "open-scene-graph"
  depends_on "pagmo"
  depends_on "spdlog"
  depends_on "tinyxml2"
  depends_on "urdfdom"

  uses_from_macos "python" => :build

  fails_with gcc: "5"

  # Include CTest for BUILD_TESTING option, upstream pr ref, https://github.com/dartsim/dart/pull/1819
  patch do
    url "https://github.com/dartsim/dart/commit/6de3bd8aede22c8dda93ba1147d3cfa97c9c8f02.patch?full_index=1"
    sha256 "d26dcb302cb7ab0491db3250e5af47c7904cdd80c6b70f9f61eee970175ece8b"
  end

  def install
    args = std_cmake_args

    if OS.mac?
      # Force to link to system GLUT (see: https://cmake.org/Bug/view.php?id=16045)
      glut_lib = "#{MacOS.sdk_path}/System/Library/Frameworks/GLUT.framework"
      args << "-DGLUT_glut_LIBRARY=#{glut_lib}"
    end

    args << "-DBUILD_TESTING=OFF"

    system "cmake", "-S", ".", "-B", "build", "-DCMAKE_INSTALL_RPATH=#{rpath}", *args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    # Clean up the build file garbage that has been installed.
    rm_r Dir["#{share}/doc/dart/**/CMakeFiles/"]
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <dart/dart.hpp>
      int main() {
        auto world = std::make_shared<dart::simulation::World>();
        assert(world != nullptr);
        return 0;
      }
    EOS
    system ENV.cxx, "test.cpp", "-I#{Formula["eigen"].include}/eigen3",
                    "-I#{include}", "-L#{lib}", "-ldart",
                    "-L#{Formula["assimp"].opt_lib}", "-lassimp",
                    "-L#{Formula["boost"].opt_lib}", "-lboost_system",
                    "-L#{Formula["libccd"].opt_lib}", "-lccd",
                    "-L#{Formula["fcl"].opt_lib}", "-lfcl",
                    "-std=c++17", "-o", "test"
    system "./test"
  end
end
