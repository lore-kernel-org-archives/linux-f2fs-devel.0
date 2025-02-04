Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E47C0218F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Feb 2025 08:06:50 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tfDxJ-0002X5-49;
	Tue, 04 Feb 2025 08:06:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1tfDxG-0002W9-Vf
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Feb 2025 08:06:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
 From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RKOsRlaNvPL21CPQTiXjgo5WtPBvPw0AkhepGLD+Uk8=; b=WTJ1zMOeuPN7rVMYTJymFWi4wd
 fpuv7qm9nSYTYF/wKRZFDzQPxtucStqN8vBke8LDDTkmHoiJ6dulmqVrF3niVD6Wdk+YSDMC2F1SY
 22kGvWGdJwELBGLhDdmBmUZHK8Cw6mJuRWtg2YdANhobZAqXJDV95mI39IGojx70DQOg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=RKOsRlaNvPL21CPQTiXjgo5WtPBvPw0AkhepGLD+Uk8=; b=A
 JjL2gM0tuuk8bwCENHpZfz1b1gVK2eZf3/6wKkVEarm8zfOoU+Y8z/aHngzTzBoDpzUf3kzpV12ZL
 092dSJEJWP4DCWbcJUpYsVrfp2W9/R7dyx3x2G1eY3SSwYNpkSvMyvL6By2cxTM61SNSiMBum8AN/
 AqA47JdiSjbxBpFg=;
Received: from mgamail.intel.com ([192.198.163.8])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tfDxD-0002a2-Km for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Feb 2025 08:06:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738656403; x=1770192403;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=TrvkCF04MEiPuvtlS3hO+AoilWK1NPuWpdTo4cFzql0=;
 b=eC5s46lglOCCI0VkvqogoH0WBGizPcLNWmOROaYWMvUOZrzJ/DQ7744A
 NOSHqSvqKeCPW+PFFO28fcB7r2porJ1iPlV0sSz/cO5tC5GiOzP4Z83D+
 Hc1y8DrRPR78b+TFb5S0vEBtMcZE3CILfDuGlqmnczi+djbalMrxLsFKb
 QlTV1xB6b+LmxKmSIpbScWs7mU21xppyQ9ek3txG9Z1CNjbOtteCO7+JS
 lOW6wJ7QJHFVKJ7ktkxhnYmkuj7Ep1XEhyFfdeGst+nP0H2k6hY9IA9vi
 nPhaX5Ycz3xMY5WeVOGZ0MICqRkWfIjIioojk+gsKI+0LIcnphjeSO7hB g==;
X-CSE-ConnectionGUID: r6bzNsqYTxKh9dfOd78Mag==
X-CSE-MsgGUID: XltjOs//TpujDtiCoZ2Crw==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="56707193"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="56707193"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 00:06:33 -0800
X-CSE-ConnectionGUID: MRQ9FLLtSL+1bqYsdw2RlA==
X-CSE-MsgGUID: 97tr8tbtSWOrrx927DjDWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="115524486"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
 by orviesa004.jf.intel.com with ESMTP; 04 Feb 2025 00:06:32 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1tfDwz-000sBX-0w;
 Tue, 04 Feb 2025 08:06:29 +0000
Date: Tue, 4 Feb 2025 16:05:33 +0800
From: kernel test robot <lkp@intel.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <202502041610.nmS1Brio-lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
X-Headers-End: 1tfDxD-0002a2-Km
Subject: [f2fs-dev] [jaegeuk-f2fs:dev-test 4/4] fs/f2fs/sysfs.c:923:6:
 warning: variable 'res' is used uninitialized whenever 'if' condition is
 false
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
Cc: llvm@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net,
 oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
head:   f0d674f43daa7e255465f8d847734a6b9b0f63db
commit: f0d674f43daa7e255465f8d847734a6b9b0f63db [4/4] f2fs: add a sysfs entry to request donate file-backed pages
config: i386-buildonly-randconfig-003-20250204 (https://download.01.org/0day-ci/archive/20250204/202502041610.nmS1Brio-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250204/202502041610.nmS1Brio-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502041610.nmS1Brio-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/f2fs/sysfs.c:923:6: warning: variable 'res' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
     923 |         if (!strcmp(a->attr.name, "reclaim_caches_kb"))
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/f2fs/sysfs.c:926:33: note: uninitialized use occurs here
     926 |         return sysfs_emit(buf, "%u\n", res);
         |                                        ^~~
   fs/f2fs/sysfs.c:923:2: note: remove the 'if' if its condition is always true
     923 |         if (!strcmp(a->attr.name, "reclaim_caches_kb"))
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     924 |                 res = f2fs_donate_files();
   fs/f2fs/sysfs.c:921:18: note: initialize the variable 'res' to silence this warning
     921 |         unsigned int res;
         |                         ^
         |                          = 0
   1 warning generated.


vim +923 fs/f2fs/sysfs.c

   918	
   919	static ssize_t f2fs_tune_show(struct f2fs_base_attr *a, char *buf)
   920	{
   921		unsigned int res;
   922	
 > 923		if (!strcmp(a->attr.name, "reclaim_caches_kb"))
   924			res = f2fs_donate_files();
   925	
   926		return sysfs_emit(buf, "%u\n", res);
   927	}
   928	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
