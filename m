Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60ABAC3064D
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Jun 2024 05:18:10 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sML2n-0001be-Ri;
	Wed, 26 Jun 2024 05:18:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1sML2m-0001bY-Gp
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Jun 2024 05:18:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PuXFwAjXAHolzwJyiMlUbX2oPLsesdcAuhPcP3cEJlo=; b=SZAJLy0Yz96/+gxsRXbGNzbNKF
 x/gMX3P5gfnGTCkQdaOpy0hSNiSPFKAlHqirm1QjeMYZ4YmargwY5kr54Ueh917TrY5bL87kzY2Ni
 YH56iehc4ah4fxN6u6OfRttCfs+iE49B07Bv+xzyYJ9aEiv48q3iS+jsQUa+RWtHktvE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PuXFwAjXAHolzwJyiMlUbX2oPLsesdcAuhPcP3cEJlo=; b=NVLIrHPm903m8TusJZ/o5PmDnS
 QK/Ko0WWl1Y8KkNtma2uwU+jsXYq7+6lET9kzNK+aAzwn3k5v7TiktT0d/7XNsdwoEST/ANqNdGpm
 Eg0agzXYI+dQegSX11kEjq/wdV49Kse6quww3e74A350b92JfDg997ozK+aMa5p9M8UA=;
Received: from mgamail.intel.com ([198.175.65.15])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sML2l-0004sZ-Mb for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Jun 2024 05:18:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719379087; x=1750915087;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=5490Gp8c+2F2vrqCK3ohvVNWHHbIVol+9XYfVM63o6k=;
 b=Dnq69xv73HK4Fu7yR3TBtNp7bvSQ+d965/p3/3x/zCeYAPezz0uXVka7
 NEUN3zASTAp3OBk06ceilERXhIaU7xLfOEBxiEDxJStvKFkLKxDNWIFCU
 rysNrXlQpD4SzX466ndTly7nREAGwBQfFlWslIGtNPIioDK8EkzvRWm0s
 WCesEb1bhW22iH0itGbc/RmJIZUwhGceZhNJ3lr6MElfJ9zOGisDVPedC
 ebnXR9lRQq9S99AjbaXhy8agaMHmijDcjApNd0BjLSjRTHRUVpY4tRDoj
 MXHYETRwZsLQfVnxRREqosmnS2ukKoUVwNxTla7UaRElcb6wlBo7XAqS/ A==;
X-CSE-ConnectionGUID: FEIrZQkSSzuxmsv1UvHDSg==
X-CSE-MsgGUID: 8T026ESXSG6SINUO0Yxygw==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="20207273"
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; d="scan'208";a="20207273"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2024 22:17:56 -0700
X-CSE-ConnectionGUID: RyKmArY4S9KBTh0nqVMD2A==
X-CSE-MsgGUID: u45v10tsRxSrhirAK5DjVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; d="scan'208";a="48261648"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
 by fmviesa003.fm.intel.com with ESMTP; 25 Jun 2024 22:17:51 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1sML2U-000F0r-1M;
 Wed, 26 Jun 2024 05:17:50 +0000
Date: Wed, 26 Jun 2024 13:17:40 +0800
From: kernel test robot <lkp@intel.com>
To: Yi Sun <yi.sun@unisoc.com>, sunyibuaa@gmail.com, tj@kernel.org,
 jaegeuk@kernel.org, chao@kernel.org
Message-ID: <202406261227.ngU3vsdJ-lkp@intel.com>
References: <20240621062617.595007-2-yi.sun@unisoc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240621062617.595007-2-yi.sun@unisoc.com>
X-Headers-End: 1sML2l-0004sZ-Mb
Subject: Re: [f2fs-dev] [PATCH 1/2] workqueue: add io priority to work_struct
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
Cc: yunlongxing23@gmail.com, ebiggers@google.com, kent.overstreet@linux.dev,
 jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, oe-kbuild-all@lists.linux.dev,
 Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Yi,

kernel test robot noticed the following build errors:

[auto build test ERROR on tj-wq/for-next]
[also build test ERROR on jaegeuk-f2fs/dev-test jaegeuk-f2fs/dev linus/master v6.10-rc5 next-20240625]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yi-Sun/workqueue-add-io-priority-to-work_struct/20240625-165935
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-next
patch link:    https://lore.kernel.org/r/20240621062617.595007-2-yi.sun%40unisoc.com
patch subject: [PATCH 1/2] workqueue: add io priority to work_struct
config: csky-randconfig-001-20240626 (https://download.01.org/0day-ci/archive/20240626/202406261227.ngU3vsdJ-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240626/202406261227.ngU3vsdJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406261227.ngU3vsdJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   csky-linux-ld: kernel/workqueue.o: in function `may_adjust_work_task_ioprio':
   workqueue.c:(.text+0x460): undefined reference to `set_task_ioprio'
   csky-linux-ld: kernel/workqueue.o: in function `restore_work_task_ioprio':
   workqueue.c:(.text+0x47c): undefined reference to `set_task_ioprio'
>> csky-linux-ld: workqueue.c:(.text+0x4bc): undefined reference to `set_task_ioprio'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
