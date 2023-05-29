Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 835F5C77B7A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 May 2023 08:19:58 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q3Y6d-0007Ff-4J;
	Mon, 29 May 2023 08:19:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1q3Y6b-0007F9-6N
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 May 2023 08:19:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vo3t0iWTPC3AKs18uEy8V540bHpUsls9KgIHC7YjMI8=; b=J8FB8p+1SXXuxPFIi7oVFScGVq
 UIg76XtlAgSb3Wb90Yyz0M5msvuhDwp/4I+fBtpvOmWF3wvRqeeq2kbD1yg6zLXRAkOtNTHq7MtuZ
 q/Rkdt7+tzyY8tpNhZ5r5YkpM2/qNxQThSF6uGzzbfjmw8s4fQYubxUEYaVzq+mA4B0k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vo3t0iWTPC3AKs18uEy8V540bHpUsls9KgIHC7YjMI8=; b=bsIYXAduoodpCjKbLGb5SHRHl7
 3tIa0q/eplm+UXHjWMQWzBI0Ls8mCz/BYxlFBzuehda/ToQHNcmf5gWjubwzUjWZpJaf6lCm6q0sB
 pogAgh7mPylxp6efJ4FUrmqV4cugLw4JembaRBg6VevGDkI9W+yKBi08psAy7BzQuZng=;
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q3Y6Z-005Z4w-Ty for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 May 2023 08:19:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685348391; x=1716884391;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=GiIE/uGGQFdSa2NJDrGRY+RO7m2JHN27QODpnLXZVFE=;
 b=Tm9jMO5zxmC8t16Y/+bNLJMB/qmua178q7nOEI5Hcg4abEqb/EwKWLxr
 D7GL/5S3ZCySgljDA3SESr8+UAPlpbR5LOSwf+exDGkMmSFDlF61ut9eL
 FLvMw3Q52dFJZ8LOUq/DxMEt3vY8/r5tV2/kApA5gVU42iZLHTimC5cZA
 RhRnWvN21qlEGGLz9pREk6q0afl0c6badLnmdZIbbP5CzEGKTfcXivWAD
 fjDlmgKEXkfNlve3JiiuLgyz1JvAy/HmiaGXK9ThaGbGZL6YnkjEZFrG6
 gysJtdy5H2DKHDJpM64AU9TiDZuJ2Re339xAA2FBNn6QVdBG/QUgdeUVL Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="418134391"
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; d="scan'208";a="418134391"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2023 01:19:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10724"; a="775849942"
X-IronPort-AV: E=Sophos;i="6.00,200,1681196400"; d="scan'208";a="775849942"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
 by fmsmga004.fm.intel.com with ESMTP; 29 May 2023 01:19:42 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1q3Y6P-000KwU-1u;
 Mon, 29 May 2023 08:19:41 +0000
Date: Mon, 29 May 2023 16:19:36 +0800
From: kernel test robot <lkp@intel.com>
To: Sheng Yong <shengyong@oppo.com>, jaegeuk@kernel.org, chao@kernel.org
Message-ID: <202305291515.JQ8RLQH1-lkp@intel.com>
References: <20230529013502.2230810-1-shengyong@oppo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230529013502.2230810-1-shengyong@oppo.com>
X-Headers-End: 1q3Y6Z-005Z4w-Ty
Subject: Re: [f2fs-dev] [PATCH] f2fs: add f2fs_ioc_[get|set]_extra_attr
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
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Sheng,

kernel test robot noticed the following build errors:

[auto build test ERROR on jaegeuk-f2fs/dev-test]
[also build test ERROR on jaegeuk-f2fs/dev next-20230525]
[cannot apply to linus/master v6.4-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sheng-Yong/f2fs-add-f2fs_ioc_-get-set-_extra_attr/20230529-093611
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
patch link:    https://lore.kernel.org/r/20230529013502.2230810-1-shengyong%40oppo.com
patch subject: [PATCH] f2fs: add f2fs_ioc_[get|set]_extra_attr
config: x86_64-randconfig-x093-20230529 (https://download.01.org/0day-ci/archive/20230529/202305291515.JQ8RLQH1-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/519a8b3bbd4d743ae67c32dfef61e8bfa0951cc5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sheng-Yong/f2fs-add-f2fs_ioc_-get-set-_extra_attr/20230529-093611
        git checkout 519a8b3bbd4d743ae67c32dfef61e8bfa0951cc5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 olddefconfig
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305291515.JQ8RLQH1-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "zstd_max_clevel" [fs/f2fs/f2fs.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
