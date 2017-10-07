From: Joe Perches <joe@perches.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: Fix bool initialization/comparison
Date: Sat, 07 Oct 2017 12:30:32 -0700
Message-ID: <1507404632.27502.5.camel@perches.com>
References: <1507383097081-778026979-0-diffsplit-thomas@m3y3r.de>
         <1507383097084-400953728-9-diffsplit-thomas@m3y3r.de>
         <CAD14+f2qcTmYa066cNFOkSycsAHaCcc+q_63U75Jv=0y49_YhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD14+f2qcTmYa066cNFOkSycsAHaCcc+q_63U75Jv=0y49_YhA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ju Hyung Park <qkrwngud825@gmail.com>, Thomas Meyer <thomas@m3y3r.de>
Cc: "jaegeuk@kernel.org" <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Sat, 2017-10-07 at 23:33 +0900, Ju Hyung Park wrote:
> Isn't this bogus?
> 
> "bool" type in Linux kernel is a typedef to "_Bool"
> and true/false is defined as 1 and 0 by enum at include/linux/stddef.h.

Bogus?  Well, not really.  It's just a neatening and it's
identical object code.

The idea is that true/false is more intelligible than 1/0
for a human reader.

> On Sat, Oct 7, 2017 at 11:02 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
> > Bool initializations should use true and false. Bool tests don't need
> > comparisons.
[]
> > diff -u -p a/fs/f2fs/data.c b/fs/f2fs/data.c
[]
> > @@ -419,7 +419,7 @@ next:
> >         bio_page = fio->encrypted_page ? fio->encrypted_page : fio->page;
> > 
> >         /* set submitted = 1 as a return value */
> > -       fio->submitted = 1;
> > +       fio->submitted = true;
> > 
> >         inc_page_count(sbi, WB_DATA_TYPE(bio_page));
> > 

And it's probably better to change the comment too.
