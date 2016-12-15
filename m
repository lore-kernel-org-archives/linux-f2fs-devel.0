From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [f2fs-dev] [GIT PULL] f2fs update for 4.10
Date: Wed, 14 Dec 2016 16:38:32 -0800
Message-ID: <CA+55aFyvoaBXmyO56_uwMEtovMD7dW8YFMM9ZaahcBLVoE=CSg@mail.gmail.com>
References: <20161212221548.GA4001@jaegeuk.local> <CA+55aFw4dRsn0dG2RO7sgKFDF--jjb8_ZgQg_ghL+tpDKH63Tw@mail.gmail.com>
 <20161214184014.GA1116@jaegeuk.local> <20161214191820.GB1116@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161214191820.GB1116@jaegeuk.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Wed, Dec 14, 2016 at 11:18 AM, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
> BTW, I just downloaded mainline, and tried to build a debian package but
> failed due to missing Documentation/Changes.
>
> I've found out that it was renamed by commit 186128f753
>  ("docs-rst: add documents to development-process")
>
> And when taking a look at its description, it was supposed to do symlink for
> document files, but did rename all of them.

Indeed.

Tssk. I've added the one symlink. Maybe we should add the others too,
but for now let's keep it minimal.

              Linus
