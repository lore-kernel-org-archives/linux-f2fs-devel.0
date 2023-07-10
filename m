Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7325FEB64D9
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 10 Jul 2023 21:03:42 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qIy2l-0007Pv-FR;
	Mon, 10 Jul 2023 21:03:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1qIy2j-0007Po-2L
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Jul 2023 21:03:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
 From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5fihLdshqL8ginTO5xg1LryBzC+BAX7WIZUbewNQJDs=; b=KYKeQ9SuFUJ14W0Bnl02G/fAwq
 vn9EETeOsybSYmYD9u7Fj6quE5MmU5pb/YiknSfMIGIvSrbc70/YRQdRo4PMGwD4YabdhbbXy7x6y
 6NktTZAo7E20s/4zgh8v4tMxAZ+b5Vwnisuheg1ze5+QgZ7v6o2isv6kjOQnqWQLilq4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5fihLdshqL8ginTO5xg1LryBzC+BAX7WIZUbewNQJDs=; b=l
 546Gzbe2yWS/v5Cu5xE5sHYcEmywdAXMUr3Anvz1oUM6pcYpELjDjWHKcInHQlbpZet6RvhHScMWj
 i8FsugS1jTfiFzrJQxpAjuxlrnXh2HrTYL+YLuQs7xrkTWIOrvg/MGwlSje4f6261ZJ55mzQh2cFa
 QKZ+05MNkfl+s5tg=;
Received: from mga07.intel.com ([134.134.136.100])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qIy2j-0001zw-Rn for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Jul 2023 21:03:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689023015; x=1720559015;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=jAJmVTgcEXtfgXzyTzCt24oi+7pn6K9VlIVWkifxXBY=;
 b=P70aK/HeLM777AsjJoPCVodOQ3dvwAryDluGXvogOzsvO5oAUJGgxL0R
 96RB3MT1mfurbJbEKj5DY6YkzMKzKioalBkeJgM3BTGq0TOwH4fOJP2ST
 7JdEQ3yP2lzxu7zWn/hzajkplfJm1Y/7nkpWFdTaezzC/1p6cqezyRiDy
 nwYXB5bpafew+cx40UMblczFg7GFCesI3GYGqOJgVVScpJV7yl3WcveCi
 yy7hHb6l+nUOlOSrj8aq96V5nBNSElsHtaINSTwOCnFXs7GcisATtP6dG
 STDgxbQ6QVSBOqk8bEoFtJPdF8LgpJmCeDX9X2do0o2XlJqzPU83npAre g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="430540180"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; d="scan'208";a="430540180"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2023 14:03:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="750467018"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; d="scan'208";a="750467018"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
 by orsmga008.jf.intel.com with ESMTP; 10 Jul 2023 14:03:28 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1qIy2Z-000406-2N;
 Mon, 10 Jul 2023 21:03:27 +0000
Date: Tue, 11 Jul 2023 05:02:35 +0800
From: kernel test robot <lkp@intel.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <202307110435.0H8FQZZW-lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
X-Headers-End: 1qIy2j-0001zw-Rn
Subject: [f2fs-dev] [jaegeuk-f2fs:dev-test 5/6] fs/f2fs/super.c:1563:23:
 error: 'struct f2fs_dev_info' has no member named 'blkz_seq'
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
head:   d73b38253cda925126fc85e32277fbe2f1b100bf
commit: 2031cbae1532cadb0838ebc1fecbfd14698b5a0a [5/6] f2fs: don't reopen the main block device in f2fs_scan_devices
config: alpha-randconfig-r021-20230710 (https://download.01.org/0day-ci/archive/20230711/202307110435.0H8FQZZW-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230711/202307110435.0H8FQZZW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307110435.0H8FQZZW-lkp@intel.com/

All errors (new ones prefixed by >>):

   fs/f2fs/super.c: In function 'destroy_device_list':
>> fs/f2fs/super.c:1563:23: error: 'struct f2fs_dev_info' has no member named 'blkz_seq'
    1563 |         kvfree(FDEV(0).blkz_seq);
         |                       ^


vim +1563 fs/f2fs/super.c

  1558	
  1559	static void destroy_device_list(struct f2fs_sb_info *sbi)
  1560	{
  1561		int i;
  1562	
> 1563		kvfree(FDEV(0).blkz_seq);
  1564		for (i = 1; i < sbi->s_ndevs; i++) {
  1565			blkdev_put(FDEV(i).bdev, sbi->sb->s_type);
  1566	#ifdef CONFIG_BLK_DEV_ZONED
  1567			kvfree(FDEV(i).blkz_seq);
  1568	#endif
  1569		}
  1570		kvfree(sbi->devs);
  1571	}
  1572	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
