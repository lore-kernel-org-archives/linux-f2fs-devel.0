Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB2FC55167
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 31 Jul 2026 08:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p+ViA+8AO9C6ICfS6YzPDwEV+EbYHZPlPpIYz6/hx1k=; b=gX3yW6BLRxz+4IeFjWLorAM4ef
	yR2n4IEGhngVa6XcpHj3vcA6A/kyIy+CCg8K4bdl6LEgT09nCrHL34bceadMBHnC4Esc53K8X29U4
	Dmp4r14WvJ5kqTBawjqeu9IBmPjv5zUKFdUBXEedNYB/zL+gPtpBjNgsaBJiCR24PVVs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wpizL-0001wF-RK;
	Fri, 31 Jul 2026 08:53:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1wpizJ-0001w9-5v
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 31 Jul 2026 08:53:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lW++SxYcQze/WbeH5BxXTT2gBovKU0YcBENrs0WZiBo=; b=bLLvMFN4FxzDI8WctfG0FdCB5k
 5NDAs3BFaQrpjIUH1kGgmgGQA5aaPlZ2i9YCAD7vCiQThmJHdLrwUzEUr1cvdJieVXiJNoEA4gFvD
 8ddRIYDPUs6zA4BA67Zx0QWNon3mKRlsm2ssO0yKur95ldn2bouOLDax14aVk1fbkAdA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lW++SxYcQze/WbeH5BxXTT2gBovKU0YcBENrs0WZiBo=; b=CqEbyvTSspbR7x1QmAKLU211k0
 8f3d7JubyX6Nr9Fjv18EG/qcbW5qGJS3AhCwgtcJNLyaHqFF+b4TV7Cm+Pofg3AtxL4i1cqfqn0G0
 vpIVNULzIiNflYRuqLlwRs4p9RsCKFq4oSZpOS5p2eNvsJN1dfUfSCgwr+KIOWxx7VBI=;
Received: from m16.mail.126.com ([117.135.210.7])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wpizH-0001id-Uk for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 31 Jul 2026 08:53:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=lW
 ++SxYcQze/WbeH5BxXTT2gBovKU0YcBENrs0WZiBo=; b=e6iXCjnREbtyVJHj6L
 H86L6aQsBgMdpkaluj3brPiquIWPmCsTRUf8OeVTkz4Co0Wp3Bf9rLWDytPIf9QM
 YP6q3GFQctu6mFIcxV2Io3Nz1Y47hRnVRIgW8mHPhy4cujlsjRU+V1aVjOorY0BC
 rAIxh7IJ1RzbB4ZWw6Inx217Y=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id
 _____wDnv7pbYmxqPYrGEQ--.15811S2; 
 Fri, 31 Jul 2026 16:52:44 +0800 (CST)
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 31 Jul 2026 16:52:15 +0800
Message-ID: <20260731085215.863900-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f1fece0c-6951-4c69-a681-344acfe1f62b@kernel.org>
References: <20260729002827.303608-1-zhaonanzhe@xiaomi.com>
 <f1fece0c-6951-4c69-a681-344acfe1f62b@kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: _____wDnv7pbYmxqPYrGEQ--.15811S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU0gAzUUUUU
X-Originating-IP: [114.247.175.250]
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsRxlNWpsYlz4QAAA39
X-Headers-End: 1wpizH-0001id-Uk
Subject: Re: [f2fs-dev] [DISCUSSION] f2fs: compatibility between compressed
 files and large folios
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
Cc: baohua@kernel.org, lipengfei28@xiaomi.com, zhangbo56@xiaomi.com,
 jaegeuk@kernel.org, Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Chao,

Thanks for the suggestion.

I am just a bit concerned about whether using it this way would violate
its intended design contract. Its comment states:

* Context: This should not be called while the inode is active as it
* is non-atomic.

Our current use case is exactly the scenario where the inode is in an
active state :)

Jaegeuk, could you also share your thoughts on this?

Thanks,

Nanzhe



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
