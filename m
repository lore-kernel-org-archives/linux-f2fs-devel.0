From: Patrick Doyle <wpdster@gmail.com>
Subject: Re: Are there limitation to the number of named
 pipes/FIFO's supported by F2FS?
Date: Thu, 6 Sep 2018 09:14:05 -0400
Message-ID: <CAF_dkJDCi4Jb0dZ1rNo97ru7idTucxLy3DXUDgBjs8rxumYLHQ@mail.gmail.com>
References: <CAF_dkJChk25fWa+bTndWa-qRsy6mW3Mj3uemXpk0QxLgY=fzeg@mail.gmail.com>
 <a24181da-6e5f-63de-d2fa-7c14c8ed592f@huawei.com>
 <20180905041210.GB15147@jaegeuk-macbookpro.roam.corp.google.com>
 <CAF_dkJCyf69FEM+RberH4NV2FZqa3b0tN+zQROkm3F1a_vFspw@mail.gmail.com>
 <8ffaeb7c-972e-f1d2-277d-0b02407f58ff@kernel.org>
 <CAF_dkJAzcBui=6ov=gbob3-T8u2n3QUyn3znSbLUkFjeg7nB8g@mail.gmail.com>
 <8778e118-1b5f-8a11-7cd7-4fe663c9da3a@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wpdster@gmail.com>) id 1fxu7P-0004bU-5l
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 06 Sep 2018 13:14:43 +0000
Received: from mail-oi0-f65.google.com ([209.85.218.65])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1fxu7K-002zOK-FM
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 06 Sep 2018 13:14:43 +0000
Received: by mail-oi0-f65.google.com with SMTP id l202-v6so20356429oig.7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 06 Sep 2018 06:14:38 -0700 (PDT)
In-Reply-To: <8778e118-1b5f-8a11-7cd7-4fe663c9da3a@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: yuchao0@huawei.com
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Wed, Sep 5, 2018 at 9:51 PM Chao Yu <yuchao0@huawei.com> wrote:
> On 2018/9/6 0:11, Patrick Doyle wrote:
> > I think it would also be worthwhile also to submit patches to the LTS
> > kernels that would check for an inhibit mounting of F2FS filesystems
> > that have features unsupported by the kernel.  If that is already in
> > place, then I shouldn't have been able to mount my f2fs partition if
> > it had the "Large nat bitmap feature" enabled.
>
> Agreed, but I tracked LTS version in Linux upstream and kernel version in
> LTS of ubuntu:
...
> And not sure that other distribution of linux will use above version
> kernel, in order to fix all version, we have to:
>
> 1. find all linux distributions LTS kernel version.
> 2. make and send the right fixing patch to all distribution's kernel
> maintainers.
>
> Thoughts?
My original recommendation was to patch the F2FS kernel driver so that
it refuses to mount filesystems with incompatible, or unknown,
options.  (I freely admit, I don't know what's involved in such a
patch, but I feel that there should be some way to validate the
features and format of the superblock to ensure that they are
compatible with the features expected by that particular version of
the kernel driver.)  I would expect that you should only need to
submit that patch against the kernel LTS versions (listed at
kernel.org) and let the distribution maintainers take it from there.

--wpd

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
