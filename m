Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F01ECA6002
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Oct 2026 08:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ANDFJ89iV2oY/ISjDD+IxJYpBw8tYeEz5wDeDCLh+5s=; b=SgsNgwSW3vOY0M/J2rRdIueHjr
	xautqasL+zw+HnsgXl0ZZp4AexSI2R+9DZpdMLc8XjWivqOzVRSgqZaWqo7UDo4zOE3dTJ+YJyWip
	tVcEdCEiMv14tSMwrOUbiDySKnzTz+OKWG3simGF0nsWFWCbVjdDs9OW7biB6pxqQxFk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xE0yL-0007cn-P9;
	Tue, 06 Oct 2026 08:56:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1xE0yJ-0007ca-Nv
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lfgbtYsfIa3Y1+/Z82Q1Kr3zd3j2Mt67FJlEnxgejh8=; b=gwhfChGbQi2yS4csY/oBKk8vD1
 psSbHV5Z0hP6R2czwOjpx461E6SVqbym2ILDTgH7wtXbIR/dfVmHs64yw/5BfkphEB4pndQ6DdJK7
 FgG3i5lUpFGdc6smBX/Ez9G3rD1Z91Y0S3FTxY7HYA/sSggWRr7unR6wBontNRkr8JJs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lfgbtYsfIa3Y1+/Z82Q1Kr3zd3j2Mt67FJlEnxgejh8=; b=GUmE7PdoB2Ta31xSpOjN6LN52n
 reWXciXCC7qOAE1akaJ0gAo1rLHpOAXzdEg3ePqVoJKkp8z42vGCY/Wqqc2UHhfHsJ4Gp4TJLrZUb
 mK54nN7ij3F88DYPOEWpFWNFzrip+lwWRHvUMIcBogMmL9p6p4BnWN+VPTtTABxC1Rls=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xE0yJ-00024S-VD for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 08:56:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 67DEC60234
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  6 Oct 2026 08:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8877F1F00893;
 Tue,  6 Oct 2026 08:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791276982;
 bh=lfgbtYsfIa3Y1+/Z82Q1Kr3zd3j2Mt67FJlEnxgejh8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iEqzWU4jqOYhGSK3tWZ9l4zIwxukxufwe3uZaA4r50qe9e3B72bAC6m96SeK/Au02
 dHVVR23Tcn/ROR12XbZMrONs24DxouhWKzDtkFDgmju0/wtQu1ztOZHVnCcK20UOMw
 7ytNgUwfNtzWMD+8TiwXqZpvXoiaxOtgiHrRS4Jpr2D3S1kp0YDFSRnjQEnOocsxje
 A1LldE9vOdp91qG5YsDLDXxsb9NjF03/PiJkl4Lu30XeK1k6tqz1GlYgwDdrVQFnDH
 D831obKyOMxrA2nVT4iz0O/p+oOIUy1B3Rku3OlCboz+qgZhGgP+4GtdjC+uNAQukn
 0PF3q7ksFcWfg==
To: fstests@vger.kernel.org
Date: Tue,  6 Oct 2026 16:55:30 +0800
Message-ID: <bbb4964b26c4c3afa4056b029abda1cfdb08ceb5.1791272793.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791272793.git.asj@kernel.org>
References: <cover.1791272793.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xE0yJ-00024S-VD
Subject: [f2fs-dev] [PATCH 04/21] fstests: add FSNOTIFYWAIT_PROG
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

Define `FSNOTIFYWAIT_PROG` for an upcoming test case that uses `fsnotifywait`.

Signed-off-by: Anand Jain <asj@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Zorro Lang <zlang@kernel.org>
---
 common/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/config b/common/config
index 69e5d83319b8..76b43b8c6ad9 100644
--- a/common/config
+++ b/common/config
@@ -242,6 +242,7 @@ export BTRFS_MAP_LOGICAL_PROG=$(type -P btrfs-map-logical)
 export PARTED_PROG="$(type -P parted)"
 export XFS_PROPERTY_PROG="$(type -P xfs_property)"
 export FSCRYPTCTL_PROG="$(type -P fscryptctl)"
+export FSNOTIFYWAIT_PROG="$(type -P fsnotifywait)"
 
 # udev wait functions.
 #
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
