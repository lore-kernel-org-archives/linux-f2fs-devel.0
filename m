From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix 32-bit format string warning
Date: Fri, 27 Jul 2018 19:18:49 +0900
Message-ID: <20180727101849.GG16155@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180724093509.1637386-1-arnd@arndb.de>
 <08f5d7dd-a271-4cef-4cf3-950c4c251c91@kernel.org>
 <CAK8P3a0DTCOtLLKRx6Z41fnweJyB8+J1zjEcpf9oQvMrj82-DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a0DTCOtLLKRx6Z41fnweJyB8+J1zjEcpf9oQvMrj82-DA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chao Yu <chao@kernel.org>, Chao Yu <yuchao0@huawei.com>, "Linux F2FS DEV, Mailing List" <linux-f2fs-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Eric Biggers <ebiggers@google.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 07/25, Arnd Bergmann wrote:
> On Wed, Jul 25, 2018 at 5:21 PM, Chao Yu <chao@kernel.org> wrote:
> > On 2018/7/24 17:34, Arnd Bergmann wrote:
> >> On 32-bit targets, size_t is often 'unsigned int', so printing it as %lu
> >> causes a warning:
> >>
> >> fs/f2fs/inode.c: In function 'sanity_check_inode':
> >> fs/f2fs/inode.c:247:4: error: format '%lu' expects argument of type 'long unsigned int', but argument 7 has type 'unsigned int' [-Werror=format=]
> >>
> >> The correct format string is %zu.
> >>
> >> Fixes: ba3a252d3367 ("f2fs: fix to do sanity check with i_extra_isize")
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > I noticed the issue, thank you for fixing it, but original buggy patch has not
> > been upstreamed yet, how about merging this fix into origial patch, if you don't
> > mind?
> 
> Yes, please do that.

Squashed.
Thank you.

> 
>       Arnd
