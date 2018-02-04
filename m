From: Chao Yu <chao@kernel.org>
Subject: Re: f2fs on top ov LV
Date: Sun, 4 Feb 2018 22:54:23 +0800
Message-ID: <2d1573a8-f783-2c27-61ab-8de412993b04@kernel.org>
References: <20180202172947.GA3981@lazy.lzy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <chao@kernel.org>) id 1eiLgx-0000wg-5b
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 04 Feb 2018 14:54:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eiLgt-0001GN-7K
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 04 Feb 2018 14:54:51 +0000
In-Reply-To: <20180202172947.GA3981@lazy.lzy>
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
To: Piergiorgio Sartor <piergiorgio.sartor@nexgo.de>, linux-f2fs-devel@lists.sourceforge.net

Hi,

On 2018/2/3 1:29, Piergiorgio Sartor wrote:
> Hi all,
> 
> I'm planning to prepare a Linux installation
> on an USB flash drive.
> 
> The idea is to have /boot (with ext, since grub2
> does not support f2fs yet) and / with f2fs.
> Both on the USB flash drive while /home will be
> somewhere else.
> 
> Now, I've a backup tool exploiting lvm snapshots
> and I would like to use it.
> 
> This means / will be on top of an LV.
> 
> Does it make any sense to have f2fs over lvm?
> Will still be some benefits from f2fs in this
> setup?

I think it's OK to build f2fs image based on lvm, and IMO, there
will be no difference when building image on lvm partition or raw
partition, since f2fs won't be aware of lvm.

> 
> How about snapshots? Could they cause problems?
> Usually the filesystem mounted from lvm snapshot
> has consistency issues, which are they usually
> solved by journal.
> I guess f2fs should be fine, but I would like to
> confirm with experts here.

f2fs supports fsfreeze and roll-forward recovery, so I think
it's fine to use lvm snapshot on f2fs image.

> 
> Of course, one possibility would be to use f2fs
> on the raw partition, waiting for snapshot to
> be implemented.
> What's the plan about this?

It's in todo list, but it's not critical for us to implement
this feature as in usual android scenario there is no strong
demand to use this feature.

Thanks,

> 
> Thanks a lot for any answers,
> 
> bye,
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
