From: Chris Mason <clm@fb.com>
Subject: Re: [GIT PULL] f2fs update for 4.16-rc1
Date: Mon, 18 Jun 2018 14:05:32 -0400
Message-ID: <0CA8215A-6529-40B1-90FB-A5902EA47549@fb.com>
References: <20180130223220.GB65489@jaegeuk-macbookpro.roam.corp.google.com>
 <20180131095446.443670dc@canb.auug.org.au>
 <20180131002535.GD65489@jaegeuk-macbookpro.roam.corp.google.com>
 <20180201092551.759f32be@canb.auug.org.au>
 <20180314101704.51aaae7f@canb.auug.org.au>
 <20180403122919.3c503f74@canb.auug.org.au>
 <20180618133817.6faba27e@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <prvs=9707f4b852=clm@fb.com>) id 1fUyZy-0002Kt-14
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Jun 2018 18:08:38 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]
 helo=mx0a-00082601.pphosted.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fUyZw-00H7vH-9g
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Jun 2018 18:08:37 +0000
In-Reply-To: <20180618133817.6faba27e@canb.auug.org.au>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Yufen Yu <yuyufen@huawei.com>, Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>, Tejun Heo <tj@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On 17 Jun 2018, at 23:38, Stephen Rothwell wrote:

> Hi Chris,
>
>
> Another merge window has passed and I am still holding this tree and 
> its
> merge fixes ...  Tomorrow I will drop the btrfs tree and rename the
> btrfs-kdave tree to btrfs.  OK?


Really sorry for the hassle, the f2fs subject line got this filtered 
into a different inbox. Tejun and Josef are working out these btrfs 
cgroup fixes, so I've pushed v4.17 to my -next tree for now.

Dave has been doing the Btrfs merge window for some time, so focusing 
linux-next on his tree is a better fit.  But either way, I've fixed my 
my email filters so you're back at the top where you belong.

-chris

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
