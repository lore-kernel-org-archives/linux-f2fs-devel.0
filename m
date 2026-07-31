Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A518C5516D
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 31 Jul 2026 09:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/cTp7rEEXOMnfcivyckiW9TLcqGXz3HqwVWxc40fXYQ=; b=j2yfBcnS/bhEHb3j32ZYncVaDD
	Brvu5nfGb1jMR3OdXlyHkVa2XtxPTdRqdsw0YN9YRloRNfbDRkdWkmnbBO0U43MX8P8FRwDkvT7fY
	4bFxcdQhTZ/BN+sVEObuTfK5Hhz9g1yL69TfEmEhiwHV+lcI137volUQQ/17Y/9GenLY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wpjDR-0007c4-Rj;
	Fri, 31 Jul 2026 09:07:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1wpjDR-0007bx-BQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 31 Jul 2026 09:07:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gNSWHjC7EN9LB9PUNY4Wiy4c+FJ/dwmQF1cNrY5LHX8=; b=Fy3oE57Y34LN1ChMBR3jqU178+
 KN7J+yuH6H7U/mL1ihdZf0PvzF1n3yx1MjF4+hfxeeWtAWYwBkIFYTmLRUCOP6EKwoG6zltjkGb5y
 V0Q7f3xPfqCpIyVX7f+aJuq5q2vuVARk2CRW0AQaCUHq7I7qJLbYiB3dV67gsQfaayIU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gNSWHjC7EN9LB9PUNY4Wiy4c+FJ/dwmQF1cNrY5LHX8=; b=gfqwWxuTGZwUzAMPqz03LY9fae
 XHnIlVhCja9cJIQs3ULHCu130tTE2LCb/dtYJCjP3jNLQLdAjDHmj94+vOwchmfFC9qdrdX4cT0dJ
 LGDfxV0dyba+68GKsxr+/s1OpRKOb/gKKh9aazFPE7doSddM4fqnjY+RwRlr7uLIkjZo=;
Received: from m16.mail.126.com ([220.197.31.6])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wpjDU-0007PY-Lz for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 31 Jul 2026 09:07:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=gN
 SWHjC7EN9LB9PUNY4Wiy4c+FJ/dwmQF1cNrY5LHX8=; b=a9Az1bXIXiVqJx4b0U
 hYl+Ok1A4BU4AkhRBc+2mJHhY++3sw+v5yrzJ/s/5lyxAzzE6j0YM7UpM/QP82gH
 1C1aZdwVB+tsrExuzPZI43cDVkig9MgVCsRqiQABgugLNWjfxrEdTCFU0SfsFN4V
 RR86ChbX4euAllr6EGteZtyoQ=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id
 _____wD3NzHHZWxqIJ5OEA--.41487S2; 
 Fri, 31 Jul 2026 17:07:20 +0800 (CST)
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 31 Jul 2026 17:07:14 +0800
Message-ID: <20260731090714.876795-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731085215.863900-1-zhaonanzhe@xiaomi.com>
References: <20260729002827.303608-1-zhaonanzhe@xiaomi.com>
 <f1fece0c-6951-4c69-a681-344acfe1f62b@kernel.org>
 <20260731085215.863900-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wD3NzHHZWxqIJ5OEA--.41487S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU0qXdDUUUU
X-Originating-IP: [114.247.175.250]
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsQhBEWpsZcgbOgAA3j
X-Headers-End: 1wpjDU-0007PY-Lz
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

The quote part of last email to reply is:

> Can we call truncate_inode_pages() after mapping_set_folio_order_range()? something
> like this:
>
>                 filemap_invalidate_lock
>
>                 mapping_set_folio_order_range(, 0, 0)

Thanks,

Nanzhe



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
