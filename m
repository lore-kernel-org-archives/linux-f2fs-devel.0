Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AE3606A32E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  5 Nov 2026 00:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZJU+WMiK;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JWS4tM2p;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CTi+m4yg;
	dkim=neutral header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gvyOKN4C
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:Message-ID:To:From:Date:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=zYHxZPfLTxEnMyRedY++lQPCsuqqK6a8WHyr4Y3vSh8=; b=ZJU+WMiKNsay60W0JtjImxMXZO
	9CL6xTRWHi9xeFUO8asEomd1iIBhoiaIr0KZVUrv/YGuykbiT8R4fmblvlCRgcVLc8bs3/7APZ/DZ
	I7Z9VuzBFLfhx3KM/noV68h+iHOouYoYYta0+H0KDH+G8ER6Pt2tlZ6jvq5DQboqoTAQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xOlZW-000000008OO-1d54;
	Thu, 05 Nov 2026 00:43:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <lkp@intel.com>) id 1xOlYv-000000008Ng-4C3V
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 00:42:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=r3zgLIpUWMJ2+WHQph3F4ViA1LF3ChoHkwJlbzmT41Y=; b=JWS4tM2p1VYJg4Y4Z43GfhmJ3K
 55yhapZw5Rzhb1GnsZok5xU31W9imB/7DQ8KP8AF86ify9ZYWaBPJkxpzPGmML0gAXQDStoF9Us4W
 VomeEWdGELBVbUGxIOnP+ei1t6H7cp6vZuEmTLc/Z2mpbFI7mUtbpgyzqvGNWZ9HnTU8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=r3zgLIpUWMJ2+WHQph3F4ViA1LF3ChoHkwJlbzmT41Y=; b=CTi+m4ygBq8H9rS9JSNclVWi02
 gG4GfB5p/r6mxtXFX2TpLJYWgE43l0vK/NoUNncxlF3yv1Eqw1/epTufdFkaoygZuosaQh9im++Wp
 FZQHKFPcnX6GbfpqEJbffmA1enRYY8M5C+BJuXhkgqd54C2IyXAnZR1eT4/H4iL+4sJ8=;
Received: from mgamail.intel.com ([198.175.65.11])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOlYu-000000003dL-0TJY
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 00:42:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793839360; x=1825375360;
 h=date:from:to:cc:subject:message-id;
 bh=0uBpTP5Dps/79hfyzKUc0lAFQpD1rxNfe12QLLmVz7Q=;
 b=gvyOKN4CbQ5caxMW3c9QbygtBm0ChyaUGI3xqTWu+zAAVp0o4/2Jn8Md
 WzWVbnxWztxz43lYuw0O7ucjuDUQDcoWogpoHYTcXSSuiJu7RrQ24BAeE
 uJSDbeC+gszMx7Ywz/AxGs7D1X6uoDPEx7U0Yuo0htzwHTNnjikrOfvyS
 FMDPeAXDE9zcC84lr6wmi5Fd/+Wwq7hvI2NS/V1p1cMWwuQs0mcaFVNqf
 YLxJIF7lTkbOgjlH6xJye3FcqzRHX1W++eLv4utLbNLpoUVRynCdhsFbS
 3/nrQNPiAj9avp8J9GQSKWiyhruH7XD/lxz/R/6AIrRdPCxyoliTXHH0U Q==;
X-CSE-ConnectionGUID: SjsIkR3LTF+ldASxZTfvYg==
X-CSE-MsgGUID: ibcI9BMlR9SxNmz+Azfv1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2494519"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2494519"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 16:42:34 -0800
X-CSE-ConnectionGUID: CQ++3C60QRKVuXv5OQZBqQ==
X-CSE-MsgGUID: 6KsMS6CsTZ2hDbQJ9YxxoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="6735986"
Received: from igk-lkp-server01.igk.intel.com (HELO 58ca8a381a5c)
 ([10.211.93.152])
 by orviesa005.jf.intel.com with ESMTP; 04 Nov 2026 16:42:32 -0800
Received: from kbuild by 58ca8a381a5c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xOlYh-000000009Pn-2pry;
 Thu, 05 Nov 2026 00:42:27 +0000
Date: Thu, 05 Nov 2026 01:41:48 +0100
From: kernel test robot <lkp@intel.com>
To: Daeho Jeong <daehojeong@google.com>
Message-ID: <202611050144.47BOVak5-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xOlYu-000000003dL-0TJY
Subject: [f2fs-dev] [jaegeuk-f2fs:dev-test 25/42] fs/f2fs/data.c:5196:34:
 warning: variable 'ffs' set but not used
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 oe-kbuild-all@lists.linux.dev
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
head:   648bdfa9bae3850908df31617e5922e0683d5fff
commit: 00f5f06b33d389a9c82286286412243795d31ed3 [25/42] f2fs: extend f2fs_folio_state for subpage blocks
config: openrisc-randconfig-2200-20261104 (https://download.01.org/0day-ci/archive/20261105/202611050144.47BOVak5-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 16.2.0
smatch: v0.5.0-9187-g5189e3fb
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261105/202611050144.47BOVak5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611050144.47BOVak5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/f2fs/data.c: In function 'prepare_large_folio_write_begin':
>> fs/f2fs/data.c:5196:34: warning: variable 'ffs' set but not used [-Wunused-but-set-variable=]
    5196 |         struct f2fs_folio_state *ffs;
         |                                  ^~~


vim +/ffs +5196 fs/f2fs/data.c

97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5190  
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5191  static int prepare_large_folio_write_begin(struct inode *inode,
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5192  					  struct folio *folio, loff_t pos,
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5193  					  unsigned int len)
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5194  {
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5195  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28 @5196  	struct f2fs_folio_state *ffs;
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5197  	size_t ori_off = offset_in_folio(folio, pos);
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5198  	size_t need_off = ori_off;
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5199  	int err = 0;
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5200  
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5201  	/*
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5202  	 * when the write did not come through f2fs_write_iter, we preallocate all
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5203  	 * blocks in the write range here.
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5204  	 */
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5205  	if (!is_inode_flag_set(inode, FI_PREALLOCATED_ALL) &&
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5206  	    !IS_DEVICE_ALIASING(inode)) {
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5207  		pgoff_t first = F2FS_BYTES_TO_BLK(sbi, pos);
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5208  		pgoff_t last = F2FS_BLK_ALIGN(sbi, pos + len);
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5209  		pgoff_t idx;
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5210  
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5211  		for (idx = first; idx < last; idx++) {
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5212  			block_t blkaddr = NULL_ADDR;
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5213  			bool node_changed = false;
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5214  
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5215  			err = __reserve_data_block(inode, idx, &blkaddr,
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5216  						   &node_changed);
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5217  			if (err)
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5218  				return err;
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5219  			if (f2fs_balance_fs_folio_locked(folio, folio->mapping,
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5220  						   node_changed))
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5221  				return -EAGAIN;
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5222  		}
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5223  	}
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5224  
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5225  	ffs = f2fs_ffs_find_or_alloc(folio);
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5226  
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5227  	/* Skip read if the folio is already fully uptodate or the write
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5228  	 * covers the entire folio.
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5229  	 */
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5230  	if (folio_test_uptodate(folio) || len == folio_size(folio))
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5231  		return 0;
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5232  
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5233  	if (!f2fs_verity_in_progress(inode) &&
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5234  	    !(pos & (PAGE_SIZE - 1)) && (pos + len) >= i_size_read(inode)) {
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5235  		size_t zoff = ori_off + len;
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5236  
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5237  		if (zoff < folio_size(folio))
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5238  			folio_zero_segment(folio, zoff, folio_size(folio));
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5239  		return 0;
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5240  	}
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5241  
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5242  	/* Inline data must have been converted before reaching here. */
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5243  	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5244  
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5245  	while (find_next_valid_block(folio, ori_off,
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5246  				     &need_off, len)) {
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5247  		struct dnode_of_data dn;
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5248  		pgoff_t index = folio->index + (need_off >> PAGE_SHIFT);
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5249  		block_t blkaddr;
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5250  
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5251  		if (!f2fs_lookup_read_extent_cache_block(inode, index,
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5252  							&blkaddr)) {
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5253  			if (IS_DEVICE_ALIASING(inode))
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5254  				return -ENODATA;
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5255  
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5256  			set_new_dnode(&dn, inode, NULL, NULL, 0);
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5257  			err = f2fs_get_dnode_of_data(&dn, index, LOOKUP_NODE);
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5258  			if (err)
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5259  				return err;
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5260  			blkaddr = dn.data_blkaddr;
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5261  			f2fs_put_dnode(&dn);
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5262  
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5263  			if (blkaddr == NEW_ADDR) {
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5264  				size_t off = offset_in_folio(folio,
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5265  							     (loff_t)index << PAGE_SHIFT);
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5266  
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5267  				folio_zero_segment(folio, off, off + PAGE_SIZE);
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5268  				f2fs_ffs_mark_subrange_uptodate(folio, off,
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5269  							       PAGE_SIZE);
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5270  				continue;
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5271  			}
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5272  		}
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5273  
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5274  		/*
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5275  		 * The read extent cache only validates the first and last
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5276  		 * block of i_ext, so check both the cached and dnode paths.
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5277  		 */
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5278  		if (!f2fs_is_valid_blkaddr(sbi, blkaddr,
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5279  					  DATA_GENERIC_ENHANCE_READ))
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5280  			return -EFSCORRUPTED;
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5281  
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5282  		err = f2fs_submit_page_read_sync(inode, folio, index, blkaddr);
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5283  		if (err)
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5284  			return err;
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5285  	}
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5286  
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5287  	return 0;
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5288  }
97c64ba5ddb76f7 Nanzhe Zhao 2026-10-28  5289  

:::::: The code at line 5196 was first introduced by commit
:::::: 97c64ba5ddb76f7b7b1db4860310b6227278c6b3 f2fs: support regular file buffered writes on large folios

:::::: TO: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
:::::: CC: Jaegeuk Kim <jaegeuk@kernel.org>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
