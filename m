From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] f2fs update for 4.18-rc1
Date: Mon, 11 Jun 2018 10:27:54 -0700
Message-ID: <CA+55aFznP4aEy7DkVfeQ_e6eXgLnswVnSJS3C51UHD_k8qYZCA@mail.gmail.com>
References: <20180611165212.GA6783@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611165212.GA6783@jaegeuk-macbookpro.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Matthew Wilcox <mawilcox@microsoft.com>
Cc: "Linux F2FS DEV, Mailing List" <linux-f2fs-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Mon, Jun 11, 2018 at 9:52 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
> In order to avoid old MM bug [1], we decided not to use __GFP_ZERO
> for the mapping for node and meta page caches.
>
> [1] https://lkml.org/lkml/2018/4/8/661

Hmm. The patch there looks correct, and anybody who relies on slab
constructors is crazy.

That email from April says it should go into stable, but it never even
went upstream..

Adding Willy to the cc, for comments, since he's been active there and
is probably the maintainer even if the MAINTAINERS file doesn't say
so..

Willy?

             Linus
