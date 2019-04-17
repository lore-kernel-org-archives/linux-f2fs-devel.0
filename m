From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs-tools: fix an improper #ifdef wrap for
 Android
Date: Wed, 17 Apr 2019 06:43:08 -0700
Message-ID: <20190417134308.GA23731@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190416075958.11857-1-qkrwngud825@gmail.com>
 <20190416203512.GE56890@jaegeuk-macbookpro.roam.corp.google.com>
 <CAD14+f3kKr50EeSoK=H9T8tk+xrx4GgSY1E5Xfrv7x2sOHm_qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1hGkqK-00057Q-UH
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Apr 2019 13:43:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hGkqJ-00BNfS-IV
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Apr 2019 13:43:16 +0000
Content-Disposition: inline
In-Reply-To: <CAD14+f3kKr50EeSoK=H9T8tk+xrx4GgSY1E5Xfrv7x2sOHm_qA@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Ju Hyung Park <qkrwngud825@gmail.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Ju Hyung,

On 04/17, Ju Hyung Park wrote:
> Hi Jaegeuk,
> 
> On Wed, Apr 17, 2019 at 5:35 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> > > -             if (c.kd < 0) {
> > > -                     MSG(0, "\tInfo: No support kernel version!\n");
> > > -                     c.kd = -2;
> >
> > If there are multiple devices, we don't need to get the version redundantly.
> 
> Oh, didn't think of that case.
> 
> Can we just read the kernel version and store to memory from
> initialization of the program?
> I see that the code for getting the kernel version is already
> duplicated in 2 different files: fsck/mount.c and mkfs/f2fs_format.c

The intention was to separate mkfs.f2fs from fsck.f2fs, since mkfs.f2fs should
be run as standalone.

> 
> /* get kernel version */
> if (c.kd >= 0) {
>         dev_read_version(c.version, 0, VERSION_LEN);
>         get_kernel_version(c.version);
> } else {
>         get_kernel_uname_version(c.version);
> }
> 
> Thanks.
