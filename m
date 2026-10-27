Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F393606A327
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 27 Oct 2026 02:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=IfZ+ACwN;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hAc0QtE4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cYe8Txv6;
	dkim=neutral header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ns6VkKiJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:Message-ID:To:From:Date:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:References:List-Unsubscribe-Post:
	List-Owner; bh=/6ndhLnxphc3D2Gh7bhXV6Hn6cs4IXcI4Hi0pj6/ujg=; b=IfZ+ACwNYMyExS
	5Rumh5dydEzpveaPxtcRMQN18MFhoGByGxKSO9M8EJA3xi2FKaoZwruGQWsg6ZreiY8D8wEu7XPPI
	MPdEgSZ0HPg+ThRxPSvqKmP303ILApjw4ldWZj70lSOcQIft2gmcAttorpjdcnw6FjKjxrOA10EVo
	WjM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xLWiJ-000000003bX-3M1I;
	Tue, 27 Oct 2026 02:14:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <yi1.lai@intel.com>) id 1xLWiI-000000003bQ-2kJZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 02:14:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ROfiEfk295+SItu3RnjH0m+IhVQ1UPEgGDJHSeo7Yss=; b=hAc0QtE4Llr4jjwVzkGoY5mXHp
 O+3Jzu5mv8SeWZkT1czbijKbs0B2zwTRnfjlNiNKUiPdf1V2x7tT2OLsPHSUxaAq4rD/gH2tMbAQP
 G/h3VU3KLpykuT1NDI9kNvkMJ8VIAcR/o32QM6Vr1+0ikZjh23UzHRlnn6swyWEUjDSY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ROfiEfk295+SItu3RnjH0m+IhVQ1UPEgGDJHSeo7Yss=; b=cYe8Txv6dsRn7txnAEGNizYMal
 mN/TA+DolNDBTi/z9VSlmbVze4zuG9FxZ8+Mla9eVAznJ2sOS/JDMev/dXkPZ12mmVl5JaVOgY4Ot
 7eh1tQnWo4Lca8z45mnv5omCz6n5giu1YCTgzXJ5J0La2LihmU3r6MDD+eLFq+7L/Az0=;
Received: from mgamail.intel.com ([192.198.163.16])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xLWiH-000000004B2-2eE5
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 02:14:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793067298; x=1824603298;
 h=date:from:to:cc:subject:message-id:mime-version: in-reply-to;
 bh=5lA/7pKtWck7vCkOArCrpRySsoQA1+UgX9wXJWD4Lx4=;
 b=Ns6VkKiJ34hIvOlAXawKsFmNYlrI7PqEIylVjlOyOoZhjEZ2Pq8qvNTH
 W4cOLWc9FGldda9Ej/tIAbH4+kDz/q9fMW21Hv/BIEZ9yi7Qc8LX3L+iC
 K9GwYIIiEWlam7qzQehy5PEU835OeSuJqNEZSfZW978RNCDHMbBdd0OUc
 O6ppihUreqKk+F1d1rvzpvbE7AaGz6BcjCmUtxYVmofIxMvegZ3DLGyqc
 xHWG/B75m+1RGQsqW+j9omWQhloEHUn0K0CerkwNUHGG7wAVA3EN8nJmB
 lxyGg6mJ3HcK2O/hyKY1eHwgLKWPFteIffN1jWtdZLJIutYIU72U8LioY g==;
X-CSE-ConnectionGUID: VQOpi/DVRLGcYmuuhUh2sg==
X-CSE-MsgGUID: 6FKyMb8pTHSBF/ICAIs1Ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1766398"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1766398"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 19:14:52 -0700
X-CSE-ConnectionGUID: BBkXL+RGRbmu52r90EePmw==
X-CSE-MsgGUID: 2uWGC/EqS3CQ29R2mdsaXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4370330"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation)
 ([10.239.182.64])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 19:14:50 -0700
Date: Tue, 27 Oct 2026 10:14:46 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Haoran Wang <haoranwangsec@gmail.com>
Message-ID: <202610262143.a92547a9-lkp@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6ad2359d.0083e9c2.97e0f.79de@mx.google.com>
X-Spam-Score: -0.5 (/)
X-Headers-End: 1xLWiH-000000004B2-2eE5
Subject: Re: [f2fs-dev] [PATCH] f2fs: verify inode data-block ownership at
 mount
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: lkp@intel.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, yi1.lai@intel.com,
 oe-lkp@lists.linux.dev, jaegeuk@kernel.org, ltp@lists.linux.it,
 haoranwangsec@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


Hello,

kernel test robot noticed "last_state.incomplete/bootup failure" on:

commit: 612a9db3132785844663564c15691d5feac8a259 ("[PATCH] f2fs: verify inode data-block ownership at mount")
url: https://github.com/intel-lab-lkp/linux/commits/Haoran-Wang/f2fs-verify-inode-data-block-ownership-at-mount/20261016-223258
base: v7.3-rc7
patch link: https://lore.kernel.org/all/6ad2359d.0083e9c2.97e0f.79de@mx.google.com/
patch subject: [PATCH] f2fs: verify inode data-block ownership at mount

in testcase: ltp
version: ltp-x86_64-af1ad307f-1_20261024 with following parameters:

	disk: 1HDD
	fs: f2fs
	test: ltp-aiodio.part2-02


config: x86_64-rhel-9.4-ltp
compiler: gcc-14
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)

[  +3.766884] [    T594] mount: /fs/sda1: fsconfig() failed: Structure needs cleaning.


If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yi1.lai@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202610262143.a92547a9-lkp@intel.com


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20261026/202610262143.a92547a9-lkp@intel.com


--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
