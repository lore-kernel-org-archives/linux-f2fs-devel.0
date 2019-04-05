From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 3/4 v2] f2fs-tools: Improve zoned model check
Date: Fri, 5 Apr 2019 09:25:01 -0700
Message-ID: <20190405162501.GB51212@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190327075410.15784-1-damien.lemoal@wdc.com>
 <20190327075410.15784-4-damien.lemoal@wdc.com>
 <b09747c2-7ac7-d8bb-db0a-59fe65718511@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1hCReS-0000Cb-IB
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 05 Apr 2019 16:25:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hCReQ-0004HU-KD
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 05 Apr 2019 16:25:12 +0000
Content-Disposition: inline
In-Reply-To: <b09747c2-7ac7-d8bb-db0a-59fe65718511@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: Damien Le Moal <damien.lemoal@wdc.com>, linux-f2fs-devel@lists.sourceforge.net

On 04/01, Chao Yu wrote:
> On 2019/3/27 15:54, Damien Le Moal wrote:
> > Return an error if an unknown zoned model is reported for a device or
> > if parsing of the device zoned model fails. Also add comments to
> > briefly explain the zone models and what to do in the absence of a
> > kernel reported zoned model for a device.
> > 
> > Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> > ---
> >  include/f2fs_fs.h   |  2 +-
> >  lib/libf2fs.c       |  8 ++++++--
> >  lib/libf2fs_zoned.c | 38 ++++++++++++++++++++++++++------------
> >  3 files changed, 33 insertions(+), 15 deletions(-)
> > 
> > diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
> > index e073723..97ad774 100644
> > --- a/include/f2fs_fs.h
> > +++ b/include/f2fs_fs.h
> > @@ -1257,7 +1257,7 @@ blk_zone_cond_str(struct blk_zone *blkz)
> >  
> >  #endif
> >  
> > -extern void f2fs_get_zoned_model(int);
> > +extern int f2fs_get_zoned_model(int);
> >  extern int f2fs_get_zone_blocks(int);
> >  extern int f2fs_check_zones(int);
> >  extern int f2fs_reset_zones(int);
> > diff --git a/lib/libf2fs.c b/lib/libf2fs.c
> > index 60b84e0..5ca1bb0 100644
> > --- a/lib/libf2fs.c
> > +++ b/lib/libf2fs.c
> > @@ -925,8 +925,12 @@ int get_device_info(int i)
> >  	}
> >  
> >  #if !defined(WITH_ANDROID) && defined(__linux__)
> > -	if (S_ISBLK(stat_buf->st_mode))
> > -		f2fs_get_zoned_model(i);
> > +	if (S_ISBLK(stat_buf->st_mode)) {
> > +		if (f2fs_get_zoned_model(i) < 0) {
> > +			free(stat_buf);
> > +			return -1;
> > +                }
> 
> Needs tabs here...

Applied. :)

> 
> Otherwise it looks good to me.
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
> 
> > +	}
> >  
> >  	if (dev->zoned_model != F2FS_ZONED_NONE) {
> >  		if (dev->zoned_model == F2FS_ZONED_HM)
> > diff --git a/lib/libf2fs_zoned.c b/lib/libf2fs_zoned.c
> > index 6e32f32..e396a95 100644
> > --- a/lib/libf2fs_zoned.c
> > +++ b/lib/libf2fs_zoned.c
> > @@ -24,7 +24,7 @@
> >  
> >  #ifdef HAVE_LINUX_BLKZONED_H
> >  
> > -void f2fs_get_zoned_model(int i)
> > +int f2fs_get_zoned_model(int i)
> >  {
> >  	struct device_info *dev = c.devices + i;
> >  	char str[128];
> > @@ -36,27 +36,41 @@ void f2fs_get_zoned_model(int i)
> >  		 "/sys/block/%s/queue/zoned",
> >  		 basename(dev->path));
> >  	file = fopen(str, "r");
> > -	if (!file)
> > -		goto not_zoned;
> > +	if (!file) {
> > +		/*
> > +		 * The kernel does not support zoned block devices, but we have
> > +		 * a block device file. This means that the device is not zoned
> > +		 * or is zoned but can be randomly written (i.e. host-aware
> > +		 * zoned model). Treat the device as a regular block device.
> > +		 */
> > +		dev->zoned_model = F2FS_ZONED_NONE;
> > +		return 0;
> > +	}
> >  
> >  	memset(str, 0, sizeof(str));
> >  	res = fscanf(file, "%s", str);
> >  	fclose(file);
> >  
> > -	if (res != 1)
> > -		goto not_zoned;
> > +	if (res != 1) {
> > +		MSG(0, "\tError: Failed to parse the device zoned model\n");
> > +		return -1;
> > +	}
> >  
> > -	if (strcmp(str, "host-aware") == 0) {
> > +	if (strcmp(str, "none") == 0) {
> > +		/* Regular block device */
> > +		dev->zoned_model = F2FS_ZONED_NONE;
> > +	} else if (strcmp(str, "host-aware") == 0) {
> > +		/* Host-aware zoned block device: can be randomly written */
> >  		dev->zoned_model = F2FS_ZONED_HA;
> > -		return;
> > -	}
> > -	if (strcmp(str, "host-managed") == 0) {
> > +	} else if (strcmp(str, "host-managed") == 0) {
> > +		/* Host-managed zoned block device: sequential writes needed */
> >  		dev->zoned_model = F2FS_ZONED_HM;
> > -		return;
> > +	} else {
> > +		MSG(0, "\tError: Unsupported device zoned model\n");
> > +		return -1;
> >  	}
> >  
> > -not_zoned:
> > -	dev->zoned_model = F2FS_ZONED_NONE;
> > +	return 0;
> >  }
> >  
> >  int f2fs_get_zone_blocks(int i)
> > 
