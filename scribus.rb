class ScribusDownloadStrategy < SubversionDownloadStrategy
  def stage
    FileUtils.cp_r @clone.children, '.'
  end
end


class Scribus < Formula
  desc 'Free Libre Open Source Desktop Publishing software'
  homepage 'https://github.com/scribusproject/homebrew-scribus'
  head 'svn://scribus.net//trunk/Scribus', :using => ScribusDownloadStrategy
  version '1.7.x'
  depends_on 'xz'
  depends_on 'cmake' => :build
  depends_on 'pkg-config' => :build
  depends_on 'little-cms2'
  depends_on 'qt5'
  depends_on 'cairo'
  depends_on 'jpeg'
  depends_on 'libtiff'
  depends_on 'fontconfig'
  depends_on 'openssl'
  depends_on 'python'
  depends_on 'hunspell'
  depends_on 'poppler'
  # depends_on 'homebrew/dupes/zlib'              # if MacOS.version <= :mavericks
  depends_on 'ghostscript' => :recommended
  depends_on 'graphicsmagick' => :recommended
  depends_on 'boost' => :recommended
  depends_on 'podofo' => :recommended
  depends_on 'freetype' => :recommended
  depends_on 'librevenge' => :recommended       # Build import filters
  depends_on 'libwpg' => :recommended           # Importer: WordPerfect Graphics
  depends_on 'libvisio' => :recommended         # Importer: MS-Visio
  depends_on 'libmspub' => :recommended         # Importer: MS-Publisher
  depends_on 'libcdr' => :recommended           # Importer: Corel Draw
  depends_on 'libpagemaker' => :recommended     # Importer: Adobe Pagemaker
  depends_on 'libfreehand' => :recommended      # Importer: Aldus/Macromedia/Adobe Freehand
  # depends_on 'open-scene-graph' => :recommended # 3D PDF Annotations

   def install
    args = std_cmake_args + %W[
    -DBUILD_OSX_BUNDLE=1
    -DCMAKE_INSTALL_PREFIX:PATH=#{prefix}/Scribus.app/Contents/
    -DQT_PREFIX=#{Formula["qt5"].opt_prefix}
    -DWANT_HUNSPELL=1
    -DWITH_PODOFO=1
    -DWANT_GRAPHICSMAGICK=1
    -DWANT_SVNVERSION=1
    -DWANT_DEBUG=1
    -DWANT_HEADERINSTALL=1
    ]
    # Other Options:
    # Enable Scripter2 with -DWANT_SCRIPTER2=1

    # ENV.libcxx if MacOS.version > :mountain_lion
    system "cmake", ".", *args
    system "make"
    system "make install"
  end
end
