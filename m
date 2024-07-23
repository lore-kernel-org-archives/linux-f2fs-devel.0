Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CFBC3DA49
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 23 Jul 2024 22:25:13 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sWNwU-0001WK-Sw;
	Tue, 23 Jul 2024 22:25:11 +0000
Received: from [172.30.29.67] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1sWNwT-0001WD-2u
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 Jul 2024 22:25:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=scmiXwDZpTExQZirAO82rqvHAwmYClRIaEzhZ4Lt7j4=; b=V6VmdzKHmTg8elfd3jj+XMw4c7
 FMQv1v7aDSq52bXCMEaukPlDB2i9e4Z0lhpee3pyP8WqGjED8rQ9aqjGGNVwjrBkPyFscxNrQc1iB
 yCQle7COvRpvL4gx3C276XA5Yb+gV7C5exPYWPdYKOfR5AOvVGgqO4hjpv9JW3T14V20=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=scmiXwDZpTExQZirAO82rqvHAwmYClRIaEzhZ4Lt7j4=; b=eI8KTZpiydMGeXNCHX2aUfaAAf
 rhvX8nLsv9nHAxzZnHty1Ygaw6J8DwBhXJVs2owhzgvlBYkRBtveHj1LpXXVpwTjygk0s4O7eRu90
 wRKW0jfEc+bgwFFrzcuyx36/9W0soctbWT7EqM2Z0OoPHQPfForlW0CLAORUS9Oe0Czo=;
Received: from mgamail.intel.com ([192.198.163.9])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sWNwS-00081K-7O for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 Jul 2024 22:25:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721773508; x=1753309508;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=ViQtFf4C97IjtVQAJCI22eGpWrUZSSX3Zptd3VqhktI=;
 b=Yfvc3ZCEBcb3NZlxRWgqGWe4DvWmGO8tWNIfiPjo5CkueQK3wEcAEO3m
 v8fsZPA+SiisIPUZVOxhebx28MQlZ4BCuxR7gZ4zmjzuJirdxEk3y20qO
 cawRy5vJsYN7gVuhB+LEQ5ZLbwiK/3p1yXRLTPNKkJBZDD0hNqjXlnXTj
 SB4mZ3gT9bZ1xCtMeeoLNWyzGz+8VdTympYGIyI/oHBale1USNvosAClC
 WYFD09i3rxlxa0o7adrbTs1NhAGp3pHRCi3K96Ebynvm6aif9ww9zFc26
 D+Zlz9GfCd1hOhXwjhxHrNvSYFWhpyqmoGYlecyY+DZlY7geVAFHR/AE3 w==;
X-CSE-ConnectionGUID: qX/jiwEGTL+CJrq1tY79fA==
X-CSE-MsgGUID: KXgRawzWR2W5q/gfSFuM2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="30088128"
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; d="scan'208";a="30088128"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2024 15:24:58 -0700
X-CSE-ConnectionGUID: 7X5r9o4GQ7eA/VcONYNQvQ==
X-CSE-MsgGUID: pOxbvXMtRta4kwubr+gFnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,231,1716274800"; d="scan'208";a="52094633"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
 by fmviesa007.fm.intel.com with ESMTP; 23 Jul 2024 15:24:53 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1sWNwB-000mOu-1Y;
 Tue, 23 Jul 2024 22:24:51 +0000
Date: Wed, 24 Jul 2024 06:24:46 +0800
From: kernel test robot <lkp@intel.com>
To: Youling Tang <youling.tang@linux.dev>, Arnd Bergmann <arnd@arndb.de>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Chris Mason <chris.mason@fusionio.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 tytso@mit.edu, Andreas Dilger <adilger.kernel@dilger.ca>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
 Chao Yu <chao@kernel.org>, Christoph Hellwig <hch@infradead.org>
Message-ID: <202407240648.afyUbKEP-lkp@intel.com>
References: <20240723083239.41533-3-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240723083239.41533-3-youling.tang@linux.dev>
X-Headers-End: 1sWNwS-00081K-7O
Subject: Re: [f2fs-dev] [PATCH 2/4] btrfs: Use module_subinit{_noexit} and
 module_subeixt helper macros
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
Cc: linux-arch@vger.kernel.org, Youling Tang <tangyouling@kylinos.cn>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-modules@vger.kernel.org, youling.tang@linux.dev,
 oe-kbuild-all@lists.linux.dev, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Youling,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kdave/for-next]
[also build test WARNING on linus/master next-20240723]
[cannot apply to jaegeuk-f2fs/dev-test jaegeuk-f2fs/dev soc/for-next v6.10]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Youling-Tang/module-Add-module_subinit-_noexit-and-module_subeixt-helper-macros/20240723-164434
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git for-next
patch link:    https://lore.kernel.org/r/20240723083239.41533-3-youling.tang%40linux.dev
patch subject: [PATCH 2/4] btrfs: Use module_subinit{_noexit} and module_subeixt helper macros
config: arm64-randconfig-004-20240724 (https://download.01.org/0day-ci/archive/20240724/202407240648.afyUbKEP-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240724/202407240648.afyUbKEP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407240648.afyUbKEP-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> aarch64-linux-ld: warning: orphan section `.subexitcall.exit' from `fs/btrfs/super.o' being placed in section `.subexitcall.exit'
>> aarch64-linux-ld: warning: orphan section `.subinitcall.init' from `fs/btrfs/super.o' being placed in section `.subinitcall.init'
>> aarch64-linux-ld: warning: orphan section `.subexitcall.exit' from `fs/btrfs/super.o' being placed in section `.subexitcall.exit'
>> aarch64-linux-ld: warning: orphan section `.subinitcall.init' from `fs/btrfs/super.o' being placed in section `.subinitcall.init'
>> aarch64-linux-ld: warning: orphan section `.subexitcall.exit' from `fs/btrfs/super.o' being placed in section `.subexitcall.exit'
>> aarch64-linux-ld: warning: orphan section `.subinitcall.init' from `fs/btrfs/super.o' being placed in section `.subinitcall.init'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
