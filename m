Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21F6C4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 Nov 2023 19:19:58 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1r0RcC-0004Pb-Mo;
	Tue, 07 Nov 2023 19:19:56 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1r0RcA-0004PS-KR
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Nov 2023 19:19:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VXY5W0+pOCVSXrYAdmCsp6aMx1ynu/+NH/Qvyu98Jso=; b=cQaDBYyKLpKvkkEMHte3VGKUN5
 vCHxaaiL0I+lLTIBfq0lSeZmA6FVjZ25QcjdvND+Co+Xxy4Sbnt5eLlTTQS4e844TDbqeNQjgEhNA
 h5uYrJWmJy7H8aHpwlOPdZdWh9tFdv8dxwQBlDwhCpUMqwd+brOPCj8o5jKhMKQVX1qA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VXY5W0+pOCVSXrYAdmCsp6aMx1ynu/+NH/Qvyu98Jso=; b=AlfWzNzpCLLmpVtlNSg0TYZbeU
 jBoRAy39BKcLqpwr4SAEvWJ7FaIyzATkg4b2S2Bt8MGGfkrq19qgl46dOcNK5GYsp2ttBgsiNDkYW
 s4WFERZiuJ/MmNZ+OEjhv7/ol1V+glI9LWicfiXN754Fm6viKSOWfpx/W5Y50fpO9V5Q=;
Received: from mgamail.intel.com ([134.134.136.24])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1r0Rc6-00BcP0-SS for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Nov 2023 19:19:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699384790; x=1730920790;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Ey6mMZSS50+XcIbiBxZUVaica+lG7Ql2zmbRMzN42mo=;
 b=jnLgjVsfCt4GLWsxiUKGWAGkbuP6PrZOm5gbDgpLzKZFh4JeASFKWMew
 iUv+akFimoDMYPT1WClU1aGtdjCe998ps7BuyP26RySIibxYSEhbCLBOW
 EQB5+FstuMLZfsIh1x7azaKooYFMKQAP+5yWnsP4brH0zVRT0ay37DPxz
 atvlc9GfIQTNhI1pu1QVQsm+0FWz1BjotYUBO5An357Jud8TJUuBOjpBr
 1BD65dUfW/9gU730u9FN7pSXRfbKoBOk5QdQ9H8p6R/+mzbu3vNs6ux9I
 FrP9SROrdGnlXMklHkOKKEo26aJZj8/KnXAIY2f3epRPOwxO19voGbtKS g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="392469679"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; d="scan'208";a="392469679"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2023 11:19:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="906519722"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; d="scan'208";a="906519722"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
 by fmsmga001.fm.intel.com with ESMTP; 07 Nov 2023 11:19:42 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
 (envelope-from <lkp@intel.com>) id 1r0Rbw-0007LU-1v;
 Tue, 07 Nov 2023 19:19:40 +0000
Date: Wed, 8 Nov 2023 03:18:36 +0800
From: kernel test robot <lkp@intel.com>
To: dslab@lzu.edu.cn, jaegeuk@kernel.org, chao@kernel.org
Message-ID: <202311080247.0hkA0mLH-lkp@intel.com>
References: <20231106121418.3675-1-dslab@lzu.edu.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231106121418.3675-1-dslab@lzu.edu.cn>
X-Headers-End: 1r0Rc6-00BcP0-SS
Subject: Re: [f2fs-dev] [PATCH] f2fs: the name of a struct is wrong in a
 comment.
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
Cc: Yang Hubin <yanghb2019@lzu.edu.cn>, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net,
 oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on jaegeuk-f2fs/dev-test]
[also build test ERROR on jaegeuk-f2fs/dev linus/master v6.6 next-20231107]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/dslab-lzu-edu-cn/f2fs-the-name-of-a-struct-is-wrong-in-a-comment/20231106-201822
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
patch link:    https://lore.kernel.org/r/20231106121418.3675-1-dslab%40lzu.edu.cn
patch subject: [PATCH] f2fs: the name of a struct is wrong in a comment.
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20231108/202311080247.0hkA0mLH-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231108/202311080247.0hkA0mLH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311080247.0hkA0mLH-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/f2fs/dir.c:10:
>> include/linux/f2fs_fs.h:501:16: error: expected ']'
           __u8 reserved[NAT_JOURNAL_RESERVED];
                         ^
   include/linux/f2fs_fs.h:474:38: note: expanded from macro 'NAT_JOURNAL_RESERVED'
                                   sizeof(struct nat_journal_entry))SIT_JOURNA
                                                                    ^
   include/linux/f2fs_fs.h:501:15: note: to match this '['
           __u8 reserved[NAT_JOURNAL_RESERVED];
                        ^
   1 error generated.


vim +501 include/linux/f2fs_fs.h

dd31866b0d55c9 Jaegeuk Kim 2012-11-02  498  
dd31866b0d55c9 Jaegeuk Kim 2012-11-02  499  struct nat_journal {
dd31866b0d55c9 Jaegeuk Kim 2012-11-02  500  	struct nat_journal_entry entries[NAT_JOURNAL_ENTRIES];
dd31866b0d55c9 Jaegeuk Kim 2012-11-02 @501  	__u8 reserved[NAT_JOURNAL_RESERVED];
dd31866b0d55c9 Jaegeuk Kim 2012-11-02  502  } __packed;
dd31866b0d55c9 Jaegeuk Kim 2012-11-02  503  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
