From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: Re: [f2fs-dev] [GIT PULL] f2fs update for 4.10
Date: Thu, 15 Dec 2016 07:33:49 -0200
Message-ID: <20161215073349.72dd923a@vento.lan>
References: <20161212221548.GA4001@jaegeuk.local>
        <CA+55aFw4dRsn0dG2RO7sgKFDF--jjb8_ZgQg_ghL+tpDKH63Tw@mail.gmail.com>
        <20161214184014.GA1116@jaegeuk.local>
        <20161214191820.GB1116@jaegeuk.local>
        <CA+55aFyvoaBXmyO56_uwMEtovMD7dW8YFMM9ZaahcBLVoE=CSg@mail.gmail.com>
        <20161215011857.GA3540@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161215011857.GA3540@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jaegeuk Kim <jaegeuk@kernel.org>, Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>, linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Em Wed, 14 Dec 2016 17:18:57 -0800
Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:

> On Wed, Dec 14, 2016 at 04:38:32PM -0800, Linus Torvalds wrote:
> > On Wed, Dec 14, 2016 at 11:18 AM, Jaegeuk Kim <jaegeuk@kernel.org> wrote:  
> > >
> > > BTW, I just downloaded mainline, and tried to build a debian package but
> > > failed due to missing Documentation/Changes.
> > >
> > > I've found out that it was renamed by commit 186128f753
> > >  ("docs-rst: add documents to development-process")
> > >
> > > And when taking a look at its description, it was supposed to do symlink for
> > > document files, but did rename all of them.  
> > 
> > Indeed.
> > 
> > Tssk. I've added the one symlink. Maybe we should add the others too,
> > but for now let's keep it minimal.  
> 
> Crap, I missed that in the patch I acked, I should have noticed that.
> 
> Thanks for the symlink, Mauro, want to make the rest of the files actual
> symlinks as well, instead of just the rename?

Hi Greg/Linus,

FYI, there was a discussion about that on lkml and linux-doc.

On that time, we considered 3 alternatives for those well-known
files:

1) just rename;
2) use symlink;
3) keep a short text telling that the file was moved, replacing
   the previous contents.

After discussions, we end by using (3) for a short group of files:
	README
	Documentation/CodingStyle
	Documentation/SubmittingPatches

>From my side, while I think all alternatives work fine, my personal
preference in short term[1] is for symlinks, just because it makes
easier to distinguish what files still need conversion.

[1] In long term, it probably makes more sense to get rid of those
symlinks at Documentation/* and use a different content at README file,
for example, adding references there to the main books at the Kernel
documentation, e. g. something like Documentation/00-INDEX.

So, if you prefer symlinks instead, feel free to merge the enclosed
patch. It is using soft symlinks, with I guess works better than
hard symlinks.

Thanks,
Mauro

[PATCH RFC] docs-rst: use symlinks for well-known renamed doc files

There was a discussion about that while reviewing commit 186128f75392
("docs-rst: add documents to development-process"), about what to do
with well-known documentation files.

On that time, we considered 3 alternatives:

1) just rename the files;
2) use symlink on the previous location;
3) keep a short text telling that the file was moved, replacing
   the previous file contents.

We end by using (3) for a short group of files:
	README
	Documentation/CodingStyle
	Documentation/SubmittingPatches

Commit 852d21ae1fcd ("docs: add back 'Documentation/Changes' file
(as symlink)") added another one (Documentation/Changes), but as a
symlink.

Let's standardize this by using the same logic on those
well-known renamed docs, replacing those files by symlinks.

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>

diff --git a/Documentation/CodingStyle b/Documentation/CodingStyle
deleted file mode 100644
index 320983ca114e..000000000000
--- a/Documentation/CodingStyle
+++ /dev/null
@@ -1 +0,0 @@
-This file has moved to process/coding-style.rst
diff --git a/Documentation/CodingStyle b/Documentation/CodingStyle
new file mode 120000
index 000000000000..b4a9864269eb
--- /dev/null
+++ b/Documentation/CodingStyle
@@ -0,0 +1 @@
+process/coding-style.rst
\ No newline at end of file
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
deleted file mode 100644
index 81455705e4a6..000000000000
--- a/Documentation/SubmittingPatches
+++ /dev/null
@@ -1 +0,0 @@
-This file has moved to process/submitting-patches.rst
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
new file mode 120000
index 000000000000..ffff4a70bb54
--- /dev/null
+++ b/Documentation/SubmittingPatches
@@ -0,0 +1 @@
+process/submitting-patches.rst
\ No newline at end of file
diff --git a/README b/README
deleted file mode 100644
index b2ba4aaa3a71..000000000000
--- a/README
+++ /dev/null
@@ -1,18 +0,0 @@
-Linux kernel
-============
-
-This file was moved to Documentation/admin-guide/README.rst
-
-Please notice that there are several guides for kernel developers and users.
-These guides can be rendered in a number of formats, like HTML and PDF.
-
-In order to build the documentation, use ``make htmldocs`` or
-``make pdfdocs``.
-
-There are various text files in the Documentation/ subdirectory,
-several of them using the Restructured Text markup notation.
-See Documentation/00-INDEX for a list of what is contained in each file.
-
-Please read the Documentation/process/changes.rst file, as it contains the
-requirements for building and running the kernel, and information about
-the problems which may result by upgrading your kernel.
diff --git a/README b/README
new file mode 120000
index 000000000000..c382e2a2017b
--- /dev/null
+++ b/README
@@ -0,0 +1 @@
+Documentation/admin-guide/README.rst
\ No newline at end of file
