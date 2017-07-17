From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: include seq_file.h for sysfs.c
Date: Mon, 17 Jul 2017 09:55:04 -0700
Message-ID: <20170717165504.GA81128@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170714010138.68665-1-jaegeuk@kernel.org>
 <8fe6971d-a71b-7641-de71-cd68adff2b74@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8fe6971d-a71b-7641-de71-cd68adff2b74@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@google.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 07/17, Chao Yu wrote:
> Hi Jaegeuk,
> 
> On 2017/7/14 9:01, Jaegeuk Kim wrote:
> > This patch includes seq_file.h to avoid compile error.
> 
> I didn't hit the error, I guess that's because we have included f2fs_fs.h
> in sysfs.c, the inclusion relation is like this:
> - sysfs.c
>  - f2fs_fs.h
>   - pagemap.h
>    - fs.h
>     - struct seq_file

What about seq ops such as seq_puts?

Thanks,

> 
> Thanks,
> 
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  fs/f2fs/sysfs.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > index 9adc202fcd6f..71191d89917d 100644
> > --- a/fs/f2fs/sysfs.c
> > +++ b/fs/f2fs/sysfs.c
> > @@ -11,6 +11,7 @@
> >   */
> >  #include <linux/proc_fs.h>
> >  #include <linux/f2fs_fs.h>
> > +#include <linux/seq_file.h>
> >  
> >  #include "f2fs.h"
> >  #include "segment.h"
> > 
