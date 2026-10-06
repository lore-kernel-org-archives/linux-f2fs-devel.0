Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A72CCA5FED
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Oct 2026 08:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SSrykSQr1SN7FFMoOlDja7kXthdtsaczGFPAGG/F/dw=; b=AFOX8iKhYjbew+A/kvVBuXCids
	Y11vcIs4k6QCEToDEB6Yras5+nhCUZ7MSHqruIn5C04Smik//4HL8vRWo9tYfKgVHf8ZwcBzGvhsH
	9UnRbbrRFeLEIGavAYxfQsos8ex5xqTjt8ND6UC9QP2J+3/ZiiNK3rDSVevbHL5JD5NQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xE0ye-0007fC-Vg;
	Tue, 06 Oct 2026 08:56:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1xE0yb-0007ej-LV
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tZ5sOykvgVOXYk7mwUNscwKSpK5HqPfMQs3F9fX2Kzk=; b=VZQcQBHuxn8jMJUJejUQCEZHYd
 wKwSCind+KtmOrxMSF2dk4boAf/C9Ym/W+ZVnk2oBqQd1wwA+hsMYv39fKiPau9VRqinoZ7dYVT2+
 AZb8DkVKprYRRX45QXH2tovEWdQ0QiICS+8JkEzYCRLlh/aqeW5jal24Ni2NRU5ovykg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tZ5sOykvgVOXYk7mwUNscwKSpK5HqPfMQs3F9fX2Kzk=; b=dtLKt0U5IwbezgmsCQzlkqmbkO
 kPmDJE6ihtvZ7QOrjFWRlSIBxdyYvFfqCEIubmNGbilolWhCqJmMoiFmgCN0E6RTkG/knxcspkhps
 ICM+njl2cTGrM6iPSjqlC8Ia7fL3wmZ9c4IYYGPxLImWq7hzJQ3XIFkoMR01TfCS4Mac=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xE0yb-00025T-Pu for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 82F4443E12
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  6 Oct 2026 08:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8BA01F00893;
 Tue,  6 Oct 2026 08:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791277000;
 bh=tZ5sOykvgVOXYk7mwUNscwKSpK5HqPfMQs3F9fX2Kzk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=UlgN13zAGyCw+Rg8Wp7I/TqM7Grrt/GcdxWrf4jTiyq6YWBEDPB2gIsQPyPVnqrUm
 J7ut3Etaaee/eUMOJG0pRBUyVPe4/FIubY3/R6WTa9OY0+SxkKfTsZ9ML7oukP95H+
 CBa6m0igBeZzsZ5d7PHbdB7jsrI40+esKZ6mmWoWdhL3qhZwyYSw2KCNkGkpYRGM53
 9T7QdsmjZw76TPQCXFuY+2DWwJYq9zBOQSvSJLtolSg6X/zhvCcH/JeUAKO88iJxm3
 k/m6dcZuPCw/J8m7hquX22A35VAX9DTPIQWP0XgSE7+Vp1e1YksAuRsTsKS7xGP2TU
 bzzuzrxjPdEHw==
To: fstests@vger.kernel.org
Date: Tue,  6 Oct 2026 16:55:39 +0800
Message-ID: <029bbc3a840e7681e597c752f4482b0140c312cc.1791272793.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791272793.git.asj@kernel.org>
References: <cover.1791272793.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xE0yb-00025T-Pu
Subject: [f2fs-dev] [PATCH 13/21] fstests: introduce _require_security_ima()
 helper
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
From: Anand Jain via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Anand Jain <asj@kernel.org>
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org, zlang@kernel.org,
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Verifying FSID handling in cloned filesystems with Integrity Measurement
Architecture (IMA) requires active IMA policy configuration.

Introduce _require_security_ima() to common/rc to ensure securityfs
is available and the IMA policy file is present and writable, skipping
tests with _notrun when unsupported.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 common/rc | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/common/rc b/common/rc
index a11235ec03b8..4ae3c74a52cf 100644
--- a/common/rc
+++ b/common/rc
@@ -6354,6 +6354,29 @@ _max() {
 	echo $ret
 }
 
+# Check if the requirements for Integrity Measurement Architecture (IMA) testing are met:
+# 1. securityfs is enabled in the kernel.
+# 2. securityfs is rw-mountable with the IMA policy loadable.
+_require_security_ima()
+{
+	[ -d /sys/kernel/security ] || _notrun "kernel doesn't support securityfs"
+
+	# securityfs may not be mounted yet on the host; mount it read-only
+	# in a scratch location just to probe for IMA support.
+	local se_mnt="${TEST_MNT}/${seq}/se_mnt"
+	local has_ima=1
+
+	mkdir -p "${se_mnt}"
+	_mount -t securityfs securityfs "${se_mnt}" 2>/dev/null || _notrun "cannot mount securityfs"
+
+	[ -d "${se_mnt}/ima" ] || has_ima=0
+	[ -w "${se_mnt}/ima/policy" ] || _notrun "IMA policy not writable"
+
+	_unmount "${se_mnt}"
+
+	[ $has_ima -eq 1 ] || _notrun "kernel doesn't support IMA"
+}
+
 # Due to reasons explained in fio commit 40f1fc11d, fio version between
 # v3.33 and v3.38 have atomic= feature but it is a no-op and doesn't do
 # RWF_ATOMIC write. Hence, use this helper to ensure fio has the
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
