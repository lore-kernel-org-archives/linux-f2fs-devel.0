Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCD4CA9ED2
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 12:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XXpfsSrnw+CqQGBLoxYH11NZKq8tJvzi1fyD4mTGHJw=; b=KX3e4+DHv1t8WM1E5PhhBevxzU
	IXB13aKTeIuU+6lxWpAo40R6n5FJxjPZIHPxIgg39ajt7dVKGw9nTdSIxL1jYy4trbOVK+LeqDPtL
	iZtLtp6LL9GKBxtxNnlzFQgppVe9hmPMgy8GybhuY9uq/wP2eKFUj/VL+sWzN8sjm7d8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGbCQ-0002Xb-VV;
	Tue, 13 Oct 2026 12:01:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1xGbCP-0002XU-L1
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 12:01:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hwZefteMn9pVxUSTiKPWp0J4O2bJvCrbYBkS4lMM/4c=; b=D4crdFfie+rIcGOGfOvc5Y40mc
 xS9NqigldpXPygPlRTSmKxagt4ymALIUhnt+rSupW3SounWHJU67vF5klt0JcpfWL/2Awpl6fIyFK
 V6LKQYERLY52EYsy3Vw4JUJuw7dhaYbbzqWFuGM/valiR3ngg0wEdUm2CTwuRUMl+6Ao=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hwZefteMn9pVxUSTiKPWp0J4O2bJvCrbYBkS4lMM/4c=; b=hflkMOyiEoaFhaz+3E29am/YC/
 GiMOmno/s3lCBhnt3hi6Pr/IJatU2yw3sM6NIieP6gjcJI8opu2mGU5tkKAxhlAcYPtMD546jU1BT
 8WheB/VkNqMwcgHmhSFtSdtdhKivmzmBODpVFTAKcdoirmqf3BY6LmnvW4Uu4eLNC2fs=;
Received: from m16.mail.126.com ([220.197.31.8])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGbCH-0005hc-RC for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 12:01:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=hw
 ZefteMn9pVxUSTiKPWp0J4O2bJvCrbYBkS4lMM/4c=; b=EtcJJeXYsLAghqvHu8
 E9F/Qbg7aipLTfQE0JJ1RWqBSpF+YkhuSgGBOIE0iEdkfZoClsxl1nk5pWG9vSma
 yfHti3ctukFsJuoFE0z9WP/F2QVqjTvoBqTKy8gmcc2kKFsLzrnoA6d5bKBs2qKE
 cAM+Y33myHGJQKmskoR79jmRc=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id
 _____wDXv+mAHc5qKrfQBQ--.49922S2; 
 Tue, 13 Oct 2026 20:01:04 +0800 (CST)
To: Chao Yu <chao@kernel.org>
Date: Tue, 13 Oct 2026 20:01:01 +0800
Message-ID: <20261013120101.975995-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1b2831dc-8d8a-4216-811e-22396fc9e35d@kernel.org>
References: <1b2831dc-8d8a-4216-811e-22396fc9e35d@kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: _____wDXv+mAHc5qKrfQBQ--.49922S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw4rJryUAw4rJw4UJr1kZrb_yoW3JFcE9F
 y8uFWFyas2kr1UCFs3Cw1IkrWFyF4jgF4xAw4rZw1qvan5JFWUuwn0vrZ2ganxGF4xJw15
 ur109345Ww4UGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUo7K3UUUUU==
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBowC1hWrOHYC2+gAA3m
X-Headers-End: 1xGbCH-0005hc-RC
Subject: Re: [f2fs-dev] [PATCH v3 12/17] f2fs: handle partial truncate of
 large folio dirty subpages
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
From: Nanzhe Zhao via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 Daeho Jeong <daehojeong@google.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

> writeback vs truncate on atomic file?

Yes. For example, truncate can dirty such a subpage without reserving a
COW block:

	f2fs_setattr()
	  |
	  v
	f2fs_truncate()
	  |
	  v
	f2fs_truncate_blocks()
	  |
	  v
	f2fs_do_truncate_blocks()
	  |
	  v
	truncate_partial_data_page()
	  |
	  v
	f2fs_ffs_mark_subrange_dirty()

Truncate a 10000-byte file to 9000 bytes (from = 9000):

	[0          4096        8192    9000       12288]
	|-- subpage0 --|-- subpage1 --|---- subpage2 ----|
	                              ^      ^
	                              |      +-- zeroed [9000, 12288) & marked dirty
	                              +-- truncation pos (offset 808 in subpage2)

subpage2 [8192, 12288) has no block reserved in the COW inode. When
writeback later does the COW lookup for this dirty subpage, it returns
ENOENT/NULL_ADDR and falls back to the original inode.

Thanks,



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
