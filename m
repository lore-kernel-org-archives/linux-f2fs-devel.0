Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2274C61DC2
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-Id:MIME-Version:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=towGqRGF68QZli9+9LP8cL3/GnWFvOPgKN4NNylFAC4=; b=K4swjl1y7FnJYIuCtEdQt9/wB9
	1BFd7WlUnA8irxbF9pbePRSQkILsZi6gkashaIVKxttFhGsmDGEI2XiTrFXwAZmh2CzsemTZgc/ZF
	3ubrs5e1n8fXme49vh9R/5S5ACWUgF3hWnvAgm1RhlJYgNn2pC6cAnGeTfRnXAG/2OwE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wz9PV-0002LF-Qn;
	Wed, 26 Aug 2026 08:55:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <devnull+jiucheng.xu.amlogic.com@kernel.org>)
 id 1wz9PT-0002L7-Sj for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 08:55:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Reply-To:Cc:To:Message-Id:Content-Transfer-Encoding
 :Content-Type:MIME-Version:Subject:Date:From:Sender:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ms9LuplDYWwkTkCSbi482CVzXvitTvy11cHq3n8T+/Q=; b=iRAUC87sE4iv1Y+Dd8l/XljS8s
 C3EP0alshxMFTgOpp9AaPRXyX+JkMjt5lYcmc1Bu3HYiinrlHbD2r7QtRIPFNq5ddQBtJjQnDXVIy
 f7nECcsezyrdaLlU23Z9Boc0+NCE4KTKO93PaKMcr9c78FPLURBTZGhKej3hT2BKRpWU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Reply-To:Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:Sender:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ms9LuplDYWwkTkCSbi482CVzXvitTvy11cHq3n8T+/Q=; b=MG1h2YIOUgVMnET+q25XbCJ4+S
 gUYOMm/krBWI3WOLrM9PgJws9asCEC91e9DQN7MusGCR29OY2VkV//NtgbrI8zKxb+wKwQ+jwxIK1
 vnAyw9MvOYDfh9PREWbj7Xtv9IsaRxW6JBzfPk/Ws6GlJOe14aiZ9YMb3xcdhJC1F44Y=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wz9PS-0004FH-9j for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 08:55:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 66B61600C4;
 Wed, 26 Aug 2026 08:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 148E4C2BCC7;
 Wed, 26 Aug 2026 08:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1787734496;
 bh=wt9A9vWjLIILGZ5qSUcJ7E2N0gZywAFxPO5dawQ/2AY=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=A6XRvIzib3dgyzzkwzYD/NiSlYPL+NwRzrC2U2+2ff2KSm15MRKWPBjrVW+cK9BzK
 64yuz4EyUIw0H+DhB5ylsO6blHcB81SFPHu7fmKUB4LcZDEgp47Sj6u92e38aR6yb/
 djCEsFpZCRhbUIxBxX6qk/+9qbAW8TCxPsf+JQgt1bxA5itsVgmnUv/1/aZxTy+Qf5
 DN5Q4pRmUHElWBcuLqsAZSAmoKfBfee0X/5Gl4/8EODMp+LBsiKBtJ4vu6xLBvhiyY
 z+9DU2NZZDCq2E5iJs2565dZWMRQY6OHe0gfrM2lG/FKFPcYOvgpUVZJ3DR3ALLoZB
 ipRKhvjb4BVYw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id E5C38C5DF97;
 Wed, 26 Aug 2026 08:54:55 +0000 (UTC)
Date: Wed, 26 Aug 2026 16:48:56 +0800
MIME-Version: 1.0
Message-Id: <20260826-origin-dev-v1-1-c21271a82100@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAHiojmoC/x3MQQqAIBBA0avIrBPUSqSrRAvRyWajMUIE4t2Tl
 m/xf4OKTFhhEw0YH6pU8oCeBITL54SS4jAYZaxy2snClCjLiI9U6IKd0ehl9TCCm/Gk95/tR+8
 faHtsv1wAAAA=
X-Change-ID: 20260818-origin-dev-0e8c63e2145a
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787734494; l=1790;
 i=jiucheng.xu@amlogic.com; s=20250821; h=from:subject:message-id;
 bh=Ub+8UxlQLsITTLZwPi9aaEIQqjRvJlIkm0jc93D0BgM=;
 b=WVt1NdpjMr8BiV8T38rO0RQGvDFlt9pBD5Ay2UhllXIRdYb4A5QNZ62vQKh+XTb4M9i7zOKpa
 gOLLWnnR+4VA0HGNGZ7L10B/+KNRjPDiDlFEtI/Ul6GRoHthvS5Hfn8
X-Developer-Key: i=jiucheng.xu@amlogic.com; a=ed25519;
 pk=Q18IjkdWCCuncSplyu+dYqIrm+n42glvoLFJTQqpb2o=
X-Endpoint-Received: by B4 Relay for jiucheng.xu@amlogic.com/20250821 with
 auth_id=498
X-Original-From: Jiucheng Xu <jiucheng.xu@amlogic.com>
X-Headers-End: 1wz9PS-0004FH-9j
Subject: [f2fs-dev] [PATCH] f2fs: force out-place update for all writes on
 compressed file
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
From: Jiucheng Xu via B4 Relay via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: jiucheng.xu@amlogic.com
Cc: Jiucheng Xu via B4 Relay <devnull+jiucheng.xu.amlogic.com@kernel.org>,
 jianxin.pan@amlogic.com, tuan.zhang@amlogic.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, tao.zeng@amlogic.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

RnJvbTogSml1Y2hlbmcgWHUgPGppdWNoZW5nLnh1QGFtbG9naWMuY29tPgoKRm9yIGNvbXByZXNz
ZWQgZmlsZSwgY29tcHJlc3NlZCB3cml0ZSBtYXkgZmFpbCBhbmQgZmFsbCBiYWNrIHRvIHJhdwp3
cml0ZS4KSWYgaW4tcGxhY2UgdXBkYXRlKElQVSkgaXMgYWxsb3dlZCwgcmF3IGRhdGEgY291bGQg
YmUgd3JpdHRlbiBpbnRvIGRpc2sKYmVmb3JlIGNsdXN0ZXIgbWV0YWRhdGEgaXMgdXBkYXRlZCBm
cm9tIGNvbXByZXNzZWQgc3RhdGUgdG8gcmF3IHN0YXRlLgpTdWRkZW4gcG93ZXItY3V0IGR1cmlu
ZyB0aGlzIHdpbmRvdyB3aWxsIHJlc3VsdCBpbiBpbmNvbnNpc3RlbmN5OgpyYXcgZGF0YSBvbiBk
aXNrIGJ1dCBtZXRhZGF0YSBzdGlsbCBleHBlY3RzIGNvbXByZXNzZWQgY29udGVudCwKd2hpY2gg
Y2F1c2VzIGRlY29tcHJlc3Npb24gZmFpbHVyZSB3aGVuIHJlYWRpbmcgdGhlIGZpbGUgbGF0ZXIu
CgpUbyBlbGltaW5hdGUgdGhpcyByaXNrIGNvbXBsZXRlbHksIGZvcmNlIG91dC1wbGFjZSB1cGRh
dGUgZm9yIGFsbAp3cml0ZSBvcGVyYXRpb25zIG9uIGNvbXByZXNzZWQgZmlsZSwgc28gSVBVIHdp
bGwgbmV2ZXIgYmUgdXNlZC4KClNpZ25lZC1vZmYtYnk6IEppdWNoZW5nIFh1IDxqaXVjaGVuZy54
dUBhbWxvZ2ljLmNvbT4KLS0tCiBmcy9mMmZzL2RhdGEuYyB8IDEwICsrKysrKy0tLS0KIDEgZmls
ZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
ZnMvZjJmcy9kYXRhLmMgYi9mcy9mMmZzL2RhdGEuYwppbmRleCA2YWUwZWIzN2QyMGY5NmVkNTFh
ODEyNGY1OWJhOTBkYWJmNjMyZmI1Li5hYWVlYTU2MWRjZDMwNjgxYjliMzdmMmY2ZjA0OTNlZDU4
ZWMyZmUwIDEwMDY0NAotLS0gYS9mcy9mMmZzL2RhdGEuYworKysgYi9mcy9mMmZzL2RhdGEuYwpA
QCAtMjk3MywxMCArMjk3MywxMiBAQCBib29sIGYyZnNfc2hvdWxkX3VwZGF0ZV9vdXRwbGFjZShz
dHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZjJmc19pb19pbmZvICpmaW8pCiAJCXJldHVybiB0
cnVlOwogCWlmIChmMmZzX3VzZWRfaW5fYXRvbWljX3dyaXRlKGlub2RlKSkKIAkJcmV0dXJuIHRy
dWU7Ci0JLyogcmV3cml0ZSBsb3cgcmF0aW8gY29tcHJlc3MgZGF0YSB3LyBPUFUgbW9kZSB0byBh
dm9pZCBmcmFnbWVudGF0aW9uICovCi0JaWYgKGYyZnNfY29tcHJlc3NlZF9maWxlKGlub2RlKSAm
JgotCQlGMkZTX09QVElPTihzYmkpLmNvbXByZXNzX21vZGUgPT0gQ09NUFJfTU9ERV9VU0VSICYm
Ci0JCWlzX2lub2RlX2ZsYWdfc2V0KGlub2RlLCBGSV9FTkFCTEVfQ09NUFJFU1MpKQorCS8qCisJ
ICogcmV3cml0ZSBsb3cgcmF0aW8gY29tcHJlc3MgZGF0YSB3LyBPUFUgbW9kZSB0byBhdm9pZCBm
cmFnbWVudGF0aW9uLgorCSAqIElmIElPIGNvbWVzIGZyb20gY29tcHJlc3NlZCB3cml0ZSBwYXRo
IGFuZCBmYWxsYmFjayB0byByYXcgd3JpdGUsCisJICogZm9yY2Ugb3V04oCRcGxhY2UgdG8gcHJl
dmVudCBtZXRhZGF0YeKAkWRhdGEgaW5jb25zaXN0ZW5jeS4KKwkgKi8KKwlpZiAoZjJmc19jb21w
cmVzc2VkX2ZpbGUoaW5vZGUpKQogCQlyZXR1cm4gdHJ1ZTsKIAogCS8qIHN3YXAgZmlsZSBpcyBt
aWdyYXRpbmcgaW4gYWxpZ25lZCB3cml0ZSBtb2RlICovCgotLS0KYmFzZS1jb21taXQ6IDBhMTcw
M2ViYTIzNzA3ZTNiMmVkZmEyYTIzMjkzNTJlN2FiYzBmZmEKY2hhbmdlLWlkOiAyMDI2MDgxOC1v
cmlnaW4tZGV2LTBlOGM2M2UyMTQ1YQoKQmVzdCByZWdhcmRzLAotLSAKSml1Y2hlbmcgWHUgPGpp
dWNoZW5nLnh1QGFtbG9naWMuY29tPgoKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJm
cy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5u
ZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
