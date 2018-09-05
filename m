From: Chao Yu <chao@kernel.org>
Subject: Re: Are there limitation to the number of named
 pipes/FIFO's supported by F2FS?
Date: Wed, 5 Sep 2018 23:57:45 +0800
Message-ID: <8ffaeb7c-972e-f1d2-277d-0b02407f58ff@kernel.org>
References: <CAF_dkJChk25fWa+bTndWa-qRsy6mW3Mj3uemXpk0QxLgY=fzeg@mail.gmail.com>
 <a24181da-6e5f-63de-d2fa-7c14c8ed592f@huawei.com>
 <20180905041210.GB15147@jaegeuk-macbookpro.roam.corp.google.com>
 <CAF_dkJCyf69FEM+RberH4NV2FZqa3b0tN+zQROkm3F1a_vFspw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1fxaBr-0002rB-B1
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 05 Sep 2018 15:57:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fxaBo-009DqP-Ov
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 05 Sep 2018 15:57:59 +0000
In-Reply-To: <CAF_dkJCyf69FEM+RberH4NV2FZqa3b0tN+zQROkm3F1a_vFspw@mail.gmail.com>
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
To: Patrick Doyle <wpdster@gmail.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2018/9/5 21:35, Patrick Doyle wrote:
> On Wed, Sep 5, 2018 at 12:12 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>> On 09/05, Chao Yu wrote:
>>> I don't remember there is any restriction to create named pipes/FIFO. If you can
>>> provider more info about the building failure, maybe I can help to trouble shoot
>>> the issue.
>>>
>>> Is there no more free inode space? can you show me filesystem usage by 'stat -f'?
>>
>> Me too. I don't think F2FS does something on pipes. :P
> Thank you both for your replies.  As per our previous email exchange,
> I had formatted the filesystem with the "-i" option.  There were
> plenty of free inodes.  I don't know what could have led to this
> issue.  This is a production system for me, so I can't afford to spend
> any more time trying to debug this.  I have made 2 changes to my
> production system in the past 10 days: I installed a 1TB SSD, and I

I can understand that.

> formatted it with F2FS.  I have run into show-stopping problems twice
> with this new configuration.  In the first case, I learned about the
> "-i" option, and I saw that help (after I backed up all of my data and
> reformatted).  In the second case, I ran into that bizarre build
> failure.  It is possible that the root cause of that failure is bad
> hardware (the new SSD).  It is possible that there is a latent bug in
> the F2FS implementation that is exposed under heavy load on my 24-core
> Xeon system.  It is possible that the second problem was a random
> occurrence and I would never see it again.  Regardless, I can't afford
> to lose another day tracking this down.  I have reformatted the SSD
> with an ext4 FS and I am crossing my fingers that the hardware is not
> the root cause.

If there is any chance to retry f2fs, let f2fs guys know anything we can help. :)

> 
> For your own reference, I am running my production system on Ubuntu
> 16.04 LTS with a "4.15.0-33-generic" kernel.

Large nat bitmap feature was supported in 4.17, old kernel can not recognize the
feature flag set in mkfs, to make sure, are you porting last f2fs to 4.15?

To Jaegeuk,

Anyway, I think we'd better to add some warn info during formatting with an
upgraded mkfs, so that it can reduce the possiblity of encountering incompatible
issue between new mkfs and old kernel.

Thanks,

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

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
