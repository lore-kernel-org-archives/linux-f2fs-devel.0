Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64DECAC5B8
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  6 Oct 2025 09:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Mime-Version:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0Fw2OCuooiUjUEI3vdpzJVH0jgh7s7SHQvuGJlOMCOU=; b=LbJK04IHNQXxmahMlkZJBpJ5EI
	q3DO2mG/WPl2iOkIQOJHG5Wm0DvLgm1r22JdrHZ9Z48eZt6VYfYVWSOFThj12Yl4PBk7wunTQteEt
	59xbSnAFfAEQ71M4iIoAh7/FGsZhC2A8WQ7uOoItHJx9lIgotBYPWIEf25tm+YXslhnI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1v5hzT-00007D-PT;
	Mon, 06 Oct 2025 09:58:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3ypLjaAwKAMs068B9r15D91zx55x2v.t53@flex--jprusakowski.bounces.google.com>)
 id 1v5hzS-000076-BE for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 06 Oct 2025 09:58:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 Mime-Version:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Sc4vGQFYPIBaWztyvb1x80Wmo5m+eEeS575TWEadZus=; b=BYTMvtdq3dbudcfiDMHJxb78ks
 tapatollOICaogXOr3CVsR74wVv+ZUR7N57C4dscsiDn22A+Ej2swDAOuwLayH9ViMamqFGBvPuGt
 6bWZCLDQTFPGCcj3BtEn0g+Wzbo2Gc1k281dsONDUuhbhQRHDQun5d6iq9PKmI4Ma/z0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:Mime-Version:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Sc4vGQFYPIBaWztyvb1x80Wmo5m+eEeS575TWEadZus=; b=A
 WjoNjr1A6vQtq650zxp/p3HNdMkkiw8tGGLmcXaOnBv47KVHogglF2nI/fUGlPUfGVICRL7xuweqg
 /LCYjyZymhtNblGJAnuWbZqCgtYfkx7gpOJG1cAtQ5qNhTCK2FcG+iQS25pEqvcembDvHs1VstJrm
 ApBFo41zrm5RXm3E=;
Received: from mail-ej1-f73.google.com ([209.85.218.73])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1v5hzR-0003tc-TH for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 06 Oct 2025 09:58:46 +0000
Received: by mail-ej1-f73.google.com with SMTP id
 a640c23a62f3a-b3f2cfc26edso441314466b.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 06 Oct 2025 02:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1759744714; x=1760349514;
 darn=lists.sourceforge.net; 
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Sc4vGQFYPIBaWztyvb1x80Wmo5m+eEeS575TWEadZus=;
 b=mESUS3YgXWlz3mcfH7KQV3NJX1Hq08PQbssE1TTqGtu+OEtgjPVvGhy7pFIpxQgogX
 PIZn0lpGPjU1QDPtQgKgJaBQ4uhPR7/aVG7T9E9+iQlXRCOvxyIPDyijqpNLXe/Ka7bC
 /PdAyYbxkFPC3UnVgjFvZ/EgCkhOMICgbjRKU52lb9hTRKj9uhRU/EsDPyQXgJdQxVmd
 qodXCO+qoX7o/9c/KlP20Dv1gCZ8cJGyMRYfTze/oQ/4sRGfzC/SdBfo4CfaWkwztWeZ
 kDBbxrj47guj1IogkuoPNgkbbT9nhWYDxwRs05m4u/wfUjaEe0d6ez13iQ1LaVXU3DMu
 EvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759744714; x=1760349514;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Sc4vGQFYPIBaWztyvb1x80Wmo5m+eEeS575TWEadZus=;
 b=FkuQ43ex7V7n72HIzLKf3zIs8wSKJFxll9MvZss/dCAaBcBaUqOg6Jexgnnd9w8Iy5
 ivvdpjt2/PQtUBngahqecHIg19u+FXEXddXkcNvGPPG5pGxWWk8EoIcqPgka0d//c2wv
 oDcfwRIfO03lgwIJwxfFcbov4Y17pErxjeIJMSbfHmNIR3Za8LxNzbXgCGtaf/UpcY+V
 vEcC99sV0zyErQ7akM+p30707DKgC+tKggN6ayfczxolwC3LSkM3oWRba/rdHP/p1z0A
 cVPVjdnD5kNSA7ogoi4Rgo3cUrX8Nm96UJdr/j/8pbFl34HOJOGNRoBTvAN+Jab8rDek
 uTaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2DSH7+AduObtsuLuQXXwAv8gfCqjp6ESnT+1O+lGcRes3c1ZPLPvsfEhZsYaOXikysPckopJZXluueR+OQ3bk@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyHR2iHFev5XbX3pb6DhI1g1Qn7Zb0wvYvPtVKi18Ircq/Oi/Or
 vhkX/lrjCjJkmBew1fcZIauQDNBAJrDAB500qnp+8Rqt7ewAvmXeAUQFrjV07HzBpz/dHInLXqk
 XGjXVP8OM3LrvM/WOKhXY5llY96UvWA==
X-Google-Smtp-Source: AGHT+IH38hWGPvZTjm7gSlYootDowCEylUmuxNHmWeR8Ovsb7/fEr161qyR4TF7YXSyDwiHegDbvcDrCXNF/znzR6Eo=
X-Received: from ejbci9.prod.google.com ([2002:a17:906:c349:b0:b3d:d79a:5f98])
 (user=jprusakowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3f21:b0:b38:6689:b9fe with SMTP id
 a640c23a62f3a-b49c2a576ebmr1293699966b.7.1759744714330; 
 Mon, 06 Oct 2025 02:58:34 -0700 (PDT)
Date: Mon,  6 Oct 2025 11:58:13 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251006095813.3497619-1-jprusakowski@google.com>
To: Zorro Lang <zlang@kernel.org>, Eric Biggers <ebiggers@google.com>,
 fstests@vger.kernel.org
X-Headers-End: 1v5hzR-0003tc-TH
Subject: [f2fs-dev] [PATCH v3] common/encrypt: Explicitly set the test file
 to uncompressed
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
From: Jan Prusakowski via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jan Prusakowski <jprusakowski@google.com>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

verify_ciphertext_for_encryption_policy() checks if encryption works
correctly by reading encrypted file's contents directly from a block device and
comparing it to a known good ciphertext.

This, however, won't work if the test file is also compressed. So this patch
adds a check if a test file is compressed and disables its compression in this
case.

Signed-off-by: Jan Prusakowski <jprusakowski@google.com>

---
Changes in v2:
The test file is now created empty first, followed by resetting the
FS_COMP_FL attribute, and then copying the test data.

Changes in v3:
Added explicit FS_NOCOMP_FL attribute to the test file.

---
 common/encrypt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/common/encrypt b/common/encrypt
index d4f6e3dc..f2687631 100644
--- a/common/encrypt
+++ b/common/encrypt
@@ -790,6 +790,13 @@ _do_verify_ciphertext_for_encryption_policy()
 	_set_encpolicy $dir $keyspec $set_encpolicy_args -f $policy_flags
 	for src in $tmp.testfile_*; do
 		dst=$dir/${src##*.}
+		# To make sure the test file is not compressed we create an empty one
+		# and disable compression first (F2FS won't allow resetting the
+		# compression flag if the file has data already in it).
+		touch $dst
+		if lsattr $dst | grep -qE ".+c.+ $dst" ; then
+			chattr -c +m $dst
+		fi
 		cp $src $dst
 		inode=$(stat -c %i $dst)
 		blocklist=$(_get_ciphertext_block_list $dst)
-- 
2.51.0.618.g983fd99d29-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
