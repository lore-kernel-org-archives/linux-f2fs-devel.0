From: Chao Yu <yuchao0@huawei.com>
Subject: Re: Are there limitation to the number of named
 pipes/FIFO's supported by F2FS?
Date: Thu, 6 Sep 2018 20:44:55 +0800
Message-ID: <325f8076-60f6-90ca-3f2e-e10672e3f782@huawei.com>
References: <CAF_dkJChk25fWa+bTndWa-qRsy6mW3Mj3uemXpk0QxLgY=fzeg@mail.gmail.com>
 <a24181da-6e5f-63de-d2fa-7c14c8ed592f@huawei.com>
 <20180905041210.GB15147@jaegeuk-macbookpro.roam.corp.google.com>
 <CAF_dkJCyf69FEM+RberH4NV2FZqa3b0tN+zQROkm3F1a_vFspw@mail.gmail.com>
 <8ffaeb7c-972e-f1d2-277d-0b02407f58ff@kernel.org>
 <CAF_dkJAzcBui=6ov=gbob3-T8u2n3QUyn3znSbLUkFjeg7nB8g@mail.gmail.com>
 <2d8ae907-a7ac-446c-d31e-d3c66ee4d8f6@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fxten-0006vQ-6f
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 06 Sep 2018 12:45:09 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fxtek-002xd2-WD
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 06 Sep 2018 12:45:08 +0000
In-Reply-To: <2d8ae907-a7ac-446c-d31e-d3c66ee4d8f6@huawei.com>
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

On 2018/9/6 10:03, Chao Yu wrote:
> On 2018/9/6 0:11, Patrick Doyle wrote:
>> What is the "Large nat bitmap feature"? (Now you've got me curious).
> 
> That's the feature backed '-i' option, it can make image support more inode
> space.
> 
> So if you use this feature in f2fs version lower than 4.17, there should be
> problem.
> 
>>
>> Would that have been turned on by default with the 1.11.0 version of
>> mkfs.f2fs I used to gain access to the "-i" option?
> 
> Not sure, in android scenario, I haven't got any report that in 256GB size
> cell phone, it runs out of inode space.
> 
> To Jaegeuk,
> 
> Maybe, we could give a hint (leaving a message) to user to use '-i' option
> if partition size is large, e.g. >= 512MB?

I mean >= 512GB, sorry.

> 
> Thanks,
> 
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
