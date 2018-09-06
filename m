From: Chao Yu <yuchao0@huawei.com>
Subject: Re: Are there limitation to the number of named
 pipes/FIFO's supported by F2FS?
Date: Thu, 6 Sep 2018 09:51:07 +0800
Message-ID: <8778e118-1b5f-8a11-7cd7-4fe663c9da3a@huawei.com>
References: <CAF_dkJChk25fWa+bTndWa-qRsy6mW3Mj3uemXpk0QxLgY=fzeg@mail.gmail.com>
 <a24181da-6e5f-63de-d2fa-7c14c8ed592f@huawei.com>
 <20180905041210.GB15147@jaegeuk-macbookpro.roam.corp.google.com>
 <CAF_dkJCyf69FEM+RberH4NV2FZqa3b0tN+zQROkm3F1a_vFspw@mail.gmail.com>
 <8ffaeb7c-972e-f1d2-277d-0b02407f58ff@kernel.org>
 <CAF_dkJAzcBui=6ov=gbob3-T8u2n3QUyn3znSbLUkFjeg7nB8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fxjS3-0007l3-CG
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 06 Sep 2018 01:51:19 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fxjS0-009fJI-Ny
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 06 Sep 2018 01:51:19 +0000
In-Reply-To: <CAF_dkJAzcBui=6ov=gbob3-T8u2n3QUyn3znSbLUkFjeg7nB8g@mail.gmail.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Patrick Doyle <wpdster@gmail.com>, chao@kernel.org
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2018/9/6 0:11, Patrick Doyle wrote:
> On Wed, Sep 5, 2018 at 11:57 AM Chao Yu <chao@kernel.org> wrote:
>> If there is any chance to retry f2fs, let f2fs guys know anything we can help. :)
>>
> Thank you.  If I have the opportunity to do that, I'll let you know.
> 
> As far as opportunities are concerned, I could just buy (have my
> employer buy) another 1TB SSD, stick it in my system, format it with
> F2FS, and see if I run into these sorts of issues again.  All that
> would take is time, which is in short supply right now.  But it's not
> out of the question.
> 
>>>
>>> For your own reference, I am running my production system on Ubuntu
>>> 16.04 LTS with a "4.15.0-33-generic" kernel.
>>
>> Large nat bitmap feature was supported in 4.17, old kernel can not recognize the
>> feature flag set in mkfs, to make sure, are you porting last f2fs to 4.15?
> What is the "Large nat bitmap feature"? (Now you've got me curious).
> 
> Would that have been turned on by default with the 1.11.0 version of
> mkfs.f2fs I used to gain access to the "-i" option?
> 
>>
>> To Jaegeuk,
>>
>> Anyway, I think we'd better to add some warn info during formatting with an
>> upgraded mkfs, so that it can reduce the possiblity of encountering incompatible
>> issue between new mkfs and old kernel.
> I think it would also be worthwhile also to submit patches to the LTS
> kernels that would check for an inhibit mounting of F2FS filesystems
> that have features unsupported by the kernel.  If that is already in
> place, then I shouldn't have been able to mount my f2fs partition if
> it had the "Large nat bitmap feature" enabled.

Agreed, but I tracked LTS version in Linux upstream and kernel version in
LTS of ubuntu:

Linux Kernel Release Status
		KERNEL VERSION
mainline:	4.19-rc2
stable:		4.18.6
stable:		4.17.19 [EOL]
longterm:	4.14.68
longterm:	4.9.125
longterm:	4.4.154

Ubuntu Status
LTS VERSION	KERNEL VERSION
16.04		4.13
18.04		4.15

Found that, version number in between formal LTS linux kernel and kernel in
LTS ubunut is not the same...

And not sure that other distribution of linux will use above version
kernel, in order to fix all version, we have to:

1. find all linux distributions LTS kernel version.
2. make and send the right fixing patch to all distribution's kernel
maintainers.

Thoughts?

> 
> --wpd
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
