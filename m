From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] f2fs update for 4.18-rc1
Date: Mon, 11 Jun 2018 11:54:07 -0700
Message-ID: <CA+55aFwEMVwijU=A7igcckkmS798m91=aEDwRpGGn7gw80ZdDA@mail.gmail.com>
References: <20180611165212.GA6783@jaegeuk-macbookpro.roam.corp.google.com>
 <CA+55aFznP4aEy7DkVfeQ_e6eXgLnswVnSJS3C51UHD_k8qYZCA@mail.gmail.com> <DM5PR2101MB08880B2FEEE593857E9501BCCB780@DM5PR2101MB0888.namprd21.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DM5PR2101MB08880B2FEEE593857E9501BCCB780@DM5PR2101MB0888.namprd21.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, "Linux F2FS DEV, Mailing List" <linux-f2fs-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Mon, Jun 11, 2018 at 11:21 AM Matthew Wilcox <mawilcox@microsoft.com> wrote:
>
> Argh, you used my Outlook email address, so you get top-posting

Hey, I think it's what you uise for your commit messages, I think
that's where I got it from..

> The radix tree does rely on constructors still.  One of the things on my todo list is to verify whether it actually makes sense to do that or not.

Ok, thanks.

> I don't really understand why Jaegeuk is changing f2fs now when we've just fixed the core kernel to make what he's doing perfectly legal.

I'm assuming it was based on the state when it wasn't legal yet.

             Linus
