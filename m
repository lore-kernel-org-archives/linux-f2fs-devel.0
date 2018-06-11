From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [GIT PULL] f2fs update for 4.18-rc1
Date: Mon, 11 Jun 2018 10:40:10 -0700
Message-ID: <20180611174010.GC6783@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180611165212.GA6783@jaegeuk-macbookpro.roam.corp.google.com>
 <CA+55aFznP4aEy7DkVfeQ_e6eXgLnswVnSJS3C51UHD_k8qYZCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFznP4aEy7DkVfeQ_e6eXgLnswVnSJS3C51UHD_k8qYZCA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <mawilcox@microsoft.com>, "Linux F2FS DEV, Mailing List" <linux-f2fs-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 06/11, Linus Torvalds wrote:
> On Mon, Jun 11, 2018 at 9:52 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> >
> > In order to avoid old MM bug [1], we decided not to use __GFP_ZERO
> > for the mapping for node and meta page caches.
> >
> > [1] https://lkml.org/lkml/2018/4/8/661
> 
> Hmm. The patch there looks correct, and anybody who relies on slab
> constructors is crazy.
> 
> That email from April says it should go into stable, but it never even
> went upstream..

Heh, I forgot to link the latest results. The MM fix was merged by:

abc1be13fd11 ("mm/filemap.c: fix NULL pointer in page_cache_tree_insert()")

Thanks,

> 
> Adding Willy to the cc, for comments, since he's been active there and
> is probably the maintainer even if the MAINTAINERS file doesn't say
> so..
> 
> Willy?
> 
>              Linus
