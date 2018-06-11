From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [GIT PULL] f2fs update for 4.18-rc1
Date: Mon, 11 Jun 2018 12:09:06 -0700
Message-ID: <20180611190906.GA11994@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180611165212.GA6783@jaegeuk-macbookpro.roam.corp.google.com>
 <CA+55aFznP4aEy7DkVfeQ_e6eXgLnswVnSJS3C51UHD_k8qYZCA@mail.gmail.com>
 <DM5PR2101MB08880B2FEEE593857E9501BCCB780@DM5PR2101MB0888.namprd21.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <DM5PR2101MB08880B2FEEE593857E9501BCCB780@DM5PR2101MB0888.namprd21.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Linux F2FS DEV, Mailing List" <linux-f2fs-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 06/11, Matthew Wilcox wrote:
> Argh, you used my Outlook email address, so you get top-posting 😉

:P

> 
> The radix tree does rely on constructors still.  One of the things on my todo list is to verify whether it actually makes sense to do that or not.  It may continue to make sense; the radix tree node is 576 bytes (9 cache lines) and the normal usage of a freshly allocated radix tree node will touch only one or two cachelines.  Radix tree nodes naturally come back to the cache zeroed, so there's no cache pollution when destroying them either.
> 
> We didn't send that patch upstream; instead we said that anybody who specifies __GFP_ZERO on a slab with constructors is crazy and fixed it with commits abc1be13fd113ddef5e2d807a466286b864caed3 and 128227e7fe4087b60f1bd31f762e61237eb23790
> 
> I don't really understand why Jaegeuk is changing f2fs now when we've just fixed the core kernel to make what he's doing perfectly legal.

Cause Sometimes I can't wait for propagation of MM-stable patches into old
-stable kernels, going into android common kernels [1], in order to resolve
huge number of kernel panic reports in time. Instead, since I keep backporting
mainline f2fs into them, I'd prefer to change f2fs to address it quickly in this
case -- not always tho.

[1] 3.18, 4.4, 4.9, and 4.14 in:
 https://android.googlesource.com/kernel/common/

> 
> > -----Original Message-----
> > From: Linus Torvalds <torvalds@linux-foundation.org>
> > Sent: Monday, June 11, 2018 1:28 PM
> > To: Jaegeuk Kim <jaegeuk@kernel.org>; Matthew Wilcox
> > <mawilcox@microsoft.com>
> > Cc: Linux F2FS DEV, Mailing List <linux-f2fs-devel@lists.sourceforge.net>; Linux
> > Kernel Mailing List <linux-kernel@vger.kernel.org>
> > Subject: Re: [GIT PULL] f2fs update for 4.18-rc1
> > 
> > On Mon, Jun 11, 2018 at 9:52 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> > >
> > > In order to avoid old MM bug [1], we decided not to use __GFP_ZERO
> > > for the mapping for node and meta page caches.
> > >
> > > [1]
> > https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flkml.org
> > %2Flkml%2F2018%2F4%2F8%2F661&data=02%7C01%7Cmawilcox%40microso
> > ft.com%7Ce69c1f9a8d6a44bda36e08d5cfc0b1a5%7C72f988bf86f141af91ab2d
> > 7cd011db47%7C1%7C0%7C636643348874608385&sdata=xbAg0cOMxyrY4NY
> > ysTj1X0DPTdxwT24oYu1cxO45nkQ%3D&reserved=0
> > 
> > Hmm. The patch there looks correct, and anybody who relies on slab
> > constructors is crazy.
> > 
> > That email from April says it should go into stable, but it never even
> > went upstream..
> > 
> > Adding Willy to the cc, for comments, since he's been active there and
> > is probably the maintainer even if the MAINTAINERS file doesn't say
> > so..
> > 
> > Willy?
> > 
> >              Linus
