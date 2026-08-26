Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB128C61DBD
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Aug 2026 03:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6+VDR9NBVk6un3Z7ovoH/Q7Q+1zqzaRRdlEOv7G1AIU=; b=XBdaYVrLhoyHvjtGxqHN/3vjM6
	XIcvyhzcfDJpdwfDECZkiv9lfDt5+mMRiTXoVtcxFyNK60TugA5/gFp6YiZMuIMl7tOK1UW6vVfDo
	PMU0jF3UpZ3LLvJusWdbB24o6sqGyeveOCPInp46J7CubVrLC5bT6rDM8yv3sWjVf80Y=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wz4WY-0008OE-Jb;
	Wed, 26 Aug 2026 03:42:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wz4WC-0008Nv-Gm
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 03:41:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bd1tWYCe/xw7dqGl1zLqdcu74EzhsWFOTCGYYlkv/3M=; b=d7c6uTFLpOdACffnVQTa7XBNQ+
 oxBkugKgU2xpTl6HoEqHbvCESfWZYAyNOiQ7TAgPC6gPiHlGG7/AR/C7VS897EtpY3ceQmrQY8DQv
 VdvkOjI9qxRqAy214yL5aVp0504c8N126vqe6yhIqOB+XFpuqxaWWR+Us8kwztAYU3rQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bd1tWYCe/xw7dqGl1zLqdcu74EzhsWFOTCGYYlkv/3M=; b=WIyiKcO66B6SlVWCvJUuZQJ/MR
 ISaNxHCGTi5AmM26SEGWeCDgGFHWkBP3s85niRU3RGDSn8qLfFpuIUkpf000SJV3pLGVRbyb9WpPp
 TfgdjVqNz+g4ddn+WDzxL2p+O/LZLA9wBomqicl6iGHsXjGLXFBVOmNtpTzAXlV8Wb4k=;
Received: from mail-pl1-f173.google.com ([209.85.214.173])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wz4W9-0003ED-Mf for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 03:41:37 +0000
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2d5655cc850so1864425ad.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 20:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787715692; x=1788320492; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bd1tWYCe/xw7dqGl1zLqdcu74EzhsWFOTCGYYlkv/3M=;
 b=B+QUcgef9AFG1QaneQ5PWChYg/jKnyfqjm0O2KoAIxTwcu0VOYUCaV5DmhwkUkT4nn
 VNdKaqH8+hnrI56YZiOCJkXoemzS9dlY2/CirwusTxxhsmpm+pFpQsRymmfmk8SXrMXl
 slDvwB48yAM/bYy40595hp6NDO/H1ZkqjIdAV7HzPgh6PWPv4U5P4FH4E6b1+9mGyKLz
 G54vaUf8LquYEBkp9udqX4almpk9HLNnxWUuVw7eKb1IM3ipekL4sq435e2or/RrgTap
 aKSzwcl4EtP/B/tsLRTd3DZkuUyClTJh6x5rC7XO4QEFOi/1MsiWWqwiLPXhmZZPclvj
 tDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787715692; x=1788320492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bd1tWYCe/xw7dqGl1zLqdcu74EzhsWFOTCGYYlkv/3M=;
 b=Xu2z8gAbRQtZzUurKTKFCP7oNkeZguFpjo+uJUA1Ew7klmfeOV1+iW1kLQRkZi/86S
 w3I8KvRsTVikfyhhpPw54uU5b026PrV73Fve5SCR7gpWRC20pyobnDvJrxklQf44jB4a
 imeOg2QzoHwRI8u4wtmJZqlSpJL8tWfXYR4rULNFVxdel7e7iDCF0mlFTs5RVArpzma5
 fsXnp3Y/6lDBEI+IsulXZS9yI6Jil0qe+SH68tD6hqCUzeK6CpKommvVojD4exUJe6uI
 PHvik0jm0u5ZxIPiE+IoxF//6rGcAz4OISdFIF/sHcxcLioZGrVkbaooaez0RqNUGNYD
 RwYw==
X-Gm-Message-State: AFuF++nAKOflHgxTBDOaMtzIUlD5HY+ENs15Tc6loqnSVZ1Ew6OSwOV4
 V6VtG64VdBILVVgyR+bZ5KakIC8uyhg+XycbAdvSNM0rGBzJM1Mw8Kei
X-Gm-Gg: AR+sD10sW0y7bkhmFiOjOvyPD8npvcGtDX6CUj5LejH91RcrxELEo/oNR9UMLMJOzyu
 OWXUBXR/OQxFoOmp1B6AeHTAfqvz5gv/Ik74MogDAHC3Z6QRwHftb2rn2bM9UN6V5MxYpexnOPI
 x/V+q3eNHMDuIaPYpuAXDKmt3WmJ2Eh8+PMAYeZMddo1WaV3mbiKNBDJ4FVcW7/QZn9edr71mzr
 MuQWvsw1Qrj/XfcDBUTOBJLlQqDd3tdl//GB755T/sNuUmXhbXI326B0DAYJozn0IQUGTpff24+
 1fZ1ugmzabAt2B7Vb+orL+1AXFTjZfLHfihCf+fZNaJkQ91Gthkx1AP8cW4n1VbMfetf8/ntgB/
 x02EKBme0s42Vvt3VVqclxbuBNm+3sPV6M3BRgvc6a+cFv0Geil8dWalPtdxzzyLV/ZHYItxTqX
 cx96sgQFDMd50co6r7fcQP4xa04vUu18UeaW8R6Hq5OG779OP0hYc9X9FG1U79px7Kc0Mk5PU8s
 CuGBE9o7J070T9asmXU0J5WbxxaxkMar08=
X-Received: by 2002:a17:903:11c3:b0:2cc:f5aa:9513 with SMTP id
 d9443c01a7336-2d707bab981mr49031765ad.10.1787715692032; 
 Tue, 25 Aug 2026 20:41:32 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d7049a9dccsm3586715ad.35.2026.08.25.20.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 20:41:31 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Wed, 26 Aug 2026 11:41:24 +0800
Message-ID: <20260826034124.2934212-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aoylp9llX9zlKm-g@google.com>
References: <20260818200121.2684318-1-jaegeuk@kernel.org>
 <aohtWfHNbUwxoQg2@google.com> <aoylp9llX9zlKm-g@google.com>
MIME-Version: 1.0
X-Headers-End: 1wz4W9-0003ED-Mf
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: don't leave the hashed inode while
 it's unlinked
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
Cc: qwjhust@gmail.com, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 viro@zeniv.linux.org.uk, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Reviewed-by: Wenjie Qi <qiwenjie@xiaomi.com>

Thanks,
Wenjie


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
