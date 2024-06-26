class Ykman < Formula
  include Language::Python::Virtualenv

  desc "Tool for managing your YubiKey configuration"
  homepage "https://developers.yubico.com/yubikey-manager/"
  url "https://files.pythonhosted.org/packages/94/1a/93777ec4776013f0c51b2d5f0c61fec8b7b54d6150a4c22bd6e2b4463d71/yubikey_manager-5.5.0.tar.gz"
  sha256 "27a616443f79690a5a74d694c642f15b6c887160a7bd81ae43b624bb325e7662"
  license "BSD-2-Clause"
  head "https://github.com/Yubico/yubikey-manager.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "7b8db2c41cd23fd0b1df0826bb39448a92d11f79513907bd5af33c6395d692c2"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "c198a828a247a6f35f1427904ddc14f6719d2ff08e4fa644bc528323c5c338d5"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5b30835f61e282c8c23a73e73e9b960cd3d6440e5db22f4983e2e6acb7830c5a"
    sha256 cellar: :any_skip_relocation, sonoma:         "69141b742777be8711a97fb5cf84f5f1f6f01f2b82eddb75caae1eb965386656"
    sha256 cellar: :any_skip_relocation, ventura:        "fb9ef6edda20fcd01e607dbeef709d7aa4b883db6318ad1fc93b20b82ff7ded5"
    sha256 cellar: :any_skip_relocation, monterey:       "f605645a199c0fd0203f3509c8565f61848fd52ac4f09cbeeb3901ff834f8e57"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2cb94fd189933ebda03e4f337ad0e41d3a8cefdb3ac33dd25463c847d11b044a"
  end

  depends_on "cmake" => :build # for pyscard
  depends_on "swig" => :build
  depends_on "cryptography"
  depends_on "python@3.12"

  uses_from_macos "pcsc-lite"

  resource "click" do
    url "https://files.pythonhosted.org/packages/96/d3/f04c7bfcf5c1862a2a5b845c6b2b360488cf47af55dfa79c98f6a6bf98b5/click-8.1.7.tar.gz"
    sha256 "ca9853ad459e787e2192211578cc907e7594e294c7ccc834310722b41b9ca6de"
  end

  resource "fido2" do
    url "https://files.pythonhosted.org/packages/78/6c/79d44841549cc3d95bdfbeaa6bc7b36892c86066b05aac44585c56113819/fido2-1.1.3.tar.gz"
    sha256 "26100f226d12ced621ca6198528ce17edf67b78df4287aee1285fee3cd5aa9fc"
  end

  resource "jaraco-classes" do
    url "https://files.pythonhosted.org/packages/06/c0/ed4a27bc5571b99e3cff68f8a9fa5b56ff7df1c2251cc715a652ddd26402/jaraco.classes-3.4.0.tar.gz"
    sha256 "47a024b51d0239c0dd8c8540c6c7f484be3b8fcf0b2d85c13825780d3b3f3acd"
  end

  resource "jaraco-context" do
    url "https://files.pythonhosted.org/packages/c9/60/e83781b07f9a66d1d102a0459e5028f3a7816fdd0894cba90bee2bbbda14/jaraco.context-5.3.0.tar.gz"
    sha256 "c2f67165ce1f9be20f32f650f25d8edfc1646a8aeee48ae06fb35f90763576d2"
  end

  resource "jaraco-functools" do
    url "https://files.pythonhosted.org/packages/bc/66/746091bed45b3683d1026cb13b8b7719e11ccc9857b18d29177a18838dc9/jaraco_functools-4.0.1.tar.gz"
    sha256 "d33fa765374c0611b52f8b3a795f8900869aa88c84769d4d1746cd68fb28c3e8"
  end

  resource "jeepney" do
    url "https://files.pythonhosted.org/packages/d6/f4/154cf374c2daf2020e05c3c6a03c91348d59b23c5366e968feb198306fdf/jeepney-0.8.0.tar.gz"
    sha256 "5efe48d255973902f6badc3ce55e2aa6c5c3b3bc642059ef3a91247bcfcc5806"
  end

  resource "keyring" do
    url "https://files.pythonhosted.org/packages/3e/e9/54f232e659f635a000d94cfbca40b9d5d617707593c3d552ec14d3ba27f1/keyring-25.2.1.tar.gz"
    sha256 "daaffd42dbda25ddafb1ad5fec4024e5bbcfe424597ca1ca452b299861e49f1b"
  end

  resource "more-itertools" do
    url "https://files.pythonhosted.org/packages/01/33/77f586de725fc990d12dda3d4efca4a41635be0f99a987b9cc3a78364c13/more-itertools-10.3.0.tar.gz"
    sha256 "e5d93ef411224fbcef366a6e8ddc4c5781bc6359d43412a65dd5964e46111463"
  end

  resource "pyscard" do
    url "https://files.pythonhosted.org/packages/7a/d9/8dd344c82d19c240349695a8de71e9d9cd9c55d62ae3952a103147e4687c/pyscard-2.0.10.tar.gz"
    sha256 "4b9b865df03b29522e80ebae17790a8b3a096a9d885cda19363b44b1a6bf5c1c"
  end

  resource "secretstorage" do
    url "https://files.pythonhosted.org/packages/53/a4/f48c9d79cb507ed1373477dbceaba7401fd8a23af63b837fa61f1dcd3691/SecretStorage-3.3.3.tar.gz"
    sha256 "2403533ef369eca6d2ba81718576c5e0f564d5cca1b58f73a8b23e7d4eeebd77"
  end

  def install
    # Fixes: smartcard/scard/helpers.c:28:22: fatal error: winscard.h: No such file or directory
    ENV.append "CFLAGS", "-I#{Formula["pcsc-lite"].opt_include}/PCSC" if OS.linux?

    virtualenv_install_with_resources
    man1.install "man/ykman.1"

    # Click doesn't support generating completions for Bash versions older than 4.4
    generate_completions_from_executable(bin/"ykman", shells: [:fish, :zsh], shell_parameter_format: :click)
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ykman --version")
  end
end
