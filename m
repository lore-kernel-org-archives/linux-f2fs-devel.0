Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B8ECA5FF0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  5 Oct 2026 20:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8yTOlDOyaFLVTLCt77u8KFNDJlqVF4s+tw78uEAHSTE=; b=fLsFvjRwv/z4Mj90ccytbN+zv6
	pKUUdnSoSWVOyZI2gi5GZRcgXw/6LZnXllSeumwG4letpohAVubFilJrXG44nYZj9Y1D1Wmuv8BHZ
	X2nBeuSnkqjDfjCL10JbUGNMVAM/XJfANWjP8DZlFxEt/LJVKt3TJJvjMfWb2lxD6yIY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xDp6o-0005GG-95;
	Mon, 05 Oct 2026 20:16:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qkrwngud825@gmail.com>) id 1xDp6m-0005G9-Ih
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 20:16:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SLE/xYZooVipo4yMSWnbAOcc4i1Ggbz1xyxv/YHIYH8=; b=f++dlY47kyFD/paMcAjIBYdWXz
 wngmdjOIG7hxC+/dLdqhCfQRuuCPxjIriDViUgtWIf3mhoc6z5k2t3Bn64Ln9AXiDauAGPXF2yG56
 crNC+Ku377/Pgzsnr2o/yuWwlKWUC0sRsxeFbYFXhEMKCQa4yJ6iq6GRdiRFNEeBJ00A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
 Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=SLE/xYZooVipo4yMSWnbAOcc4i1Ggbz1xyxv/YHIYH8=; b=I
 I0kfj5AFlMWnTIbyuEEQkBleMY0OmIUtBovncobok5XQxC3TOsJpMlM28rYz/sbN/vdbDVcrc+EQt
 ocyjp9mpVxcjHg/xrQjcmEeeWhpxqWfjUPSoH3LRJOG/XPiduk0B6rAK277rpySPiaZP82aE/rsDT
 TkJrOchl17AQ3guc=;
Received: from mail-pj1-f46.google.com ([209.85.216.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDp6i-0000zb-Nb for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 20:16:22 +0000
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-398a5aad413so1592797a91.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 05 Oct 2026 13:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791231375; x=1791836175; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SLE/xYZooVipo4yMSWnbAOcc4i1Ggbz1xyxv/YHIYH8=;
 b=oKxByGyUn4e3UlC8w6ALjC9Wyjs7F/dX6NcFIMYD2Ftv1aXzVGFy5uu/JjFqAy2tp1
 obI0fiSUSei3c+/L2gdbsIj6mMuURF9GWb7ycRTPX3J11WgGad6xm92OmIpPj+qnEG0t
 oIPO0nqeljlVD/AGn8D35ONzPGXOxIE19vOa6OMbPXNTcKrPKldBGj46llRpsVMdGKNc
 8qSONbeyAgWpZ3UHOPh9qWjuqme4r8ELdRAjwh6s4A2eVqEu09EpesCzNLfsXA5kM8jQ
 ick6vONwcXln3oKFvrxqlU7gE56SItKSocpgzicdHxODL4eOJKqBG7Fh4EwbmCy2Lvat
 5KvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791231375; x=1791836175;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SLE/xYZooVipo4yMSWnbAOcc4i1Ggbz1xyxv/YHIYH8=;
 b=H3sEMpCOICn9R3Oosnnyew4pr06PyvxvwQneOOdU+41yeyz80zgNrDEJidQjDAkBbs
 h5q9IN78XXYB4WfqPszsErXByCFSya4ElZpotgySRnhukPdAlQLuw/erQ7RsKJjKKHZ0
 6hnTvCG2LmZFET3S/abvh6E7WPvB0oRAFyqYRU+PAeZAnM9qiBgiZe5KgwzxMQKu7Gvt
 Nnx/WFpM2WGupuuGThuMmXbRKeJ3uIqJb6hWE4fUqSMDp4nxVjXKpLcpfZKyLGibQStF
 2T9X1ma6fuaGhWRcw16MyGYUADmQK3CmwrZhaAWVkyqKtjKpvWprS37POS4e67zTomNN
 FjKg==
X-Gm-Message-State: AFq9FYK357AnkKiIxhL77FYfV1j+zei6b/EpZBAhn3yNnKyzXO9YgnIQ
 eh5yejpO3Ws5igZwihOJJewSgxEe5R2WICY4R8iLYyfiC2YCYQVoh/4U3mUdwr9v
X-Gm-Gg: AYBFou3tRqkBA9eRNASRFqiUKKkaWgiiR/A3EZ0QkoH8Ln9idPgyqo4xlGpixHhDgaU
 MVrpSb1Brh1+4FBnlKh0hXQkm7zFvziVEAkuev/n3VI9NUg5OI3iJoIlBVPYSLRfPXa6TeLQnID
 izQ/ADUXKyrq/9LH0+RfdH4dqPwDiAFZkOCxRPigdG1px+iPJY1wl8X3H3B6U6pRhgNBWJe9JRq
 2PP3NTciy09KnkiOWbjnSMQVyp+GlnWnokSWJtevNikoEyT+mEYnrN8j+Ng/PY6ecQ/goWv0GAS
 VHfeOL3mkoaTt2CCEySyrHfI+m/W5lQCv5kUuTsTzlPuaH7a/TR8J9LZia6JKBqScvYqrVQZhZN
 0gVNEXFEcQIq7sH8cX/iS13pkead/nrAxBy/5lW9YB2j11g8j8ifFJnUWN+7ql7NMJ1ufWV0nmz
 wKsoO5UpI/hEqAMj4qMeF09KEtB6XoPjytz2OsnejuZVRe9EIePYJ1TjY5b71xs8G2J990RYQbT
 kHueYXOGte1C2L4Zv73YHDqKpS0fBl/5XOoibqWx0qsXacrabZO/FbY3ZRb5Q28FnZl0GkpAE5C
 sxIUqVgqH/1s/7ockcdcY2ukUObZtm+8Rb/R0yQK4LhLBDvKnrkFM3Pg/77383+dEwOekRjloQI
 VXaa9Tnq+cj1OHLOilyrfJTugnGGAQ1QbuZ0vojuzrCo7zH+jHD/7Fw==
X-Received: by 2002:a17:90b:17d0:b0:39e:4c80:f680 with SMTP id
 98e67ed59e1d1-3a7872b2fe7mr7823129a91.31.1791231374936; 
 Mon, 05 Oct 2026 13:16:14 -0700 (PDT)
Received: from arter97-x1 ([58.124.177.116]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a854257d18sm1149443a91.7.2026.10.05.13.16.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 13:16:14 -0700 (PDT)
From: Juhyung Park <qkrwngud825@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue,  6 Oct 2026 05:16:04 +0900
Message-ID: <20261005201605.693574-1-qkrwngud825@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Headers-End: 1xDp6i-0000zb-Nb
Subject: [f2fs-dev] [PATCH 1/2] f2fs-tools: fix discarded const qualifiers
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Y29tcHJlc3MuYzogSW4gZnVuY3Rpb24g4oCYZ2V0X2V4dOKAmToKY29tcHJlc3MuYzoxMzY6MTk6
IHdhcm5pbmc6IGluaXRpYWxpemF0aW9uIGRpc2NhcmRzIOKAmGNvbnN04oCZIHF1YWxpZmllciBm
cm9tIHBvaW50ZXIgdGFyZ2V0IHR5cGUgWy1XZGlzY2FyZGVkLXF1YWxpZmllcnNdCiAgMTM2IHwg
ICAgICAgICBjaGFyICpwID0gc3RycmNocihwYXRoLCAnLicpOwogICAgICB8ICAgICAgICAgICAg
ICAgICAgIF5+fn5+fn4KZjJmc2NyeXB0LmM6IEluIGZ1bmN0aW9uIOKAmGhleDJieXRl4oCZOgpm
MmZzY3J5cHQuYzoyMTA6MTk6IHdhcm5pbmc6IGFzc2lnbm1lbnQgZGlzY2FyZHMg4oCYY29uc3Ti
gJkgcXVhbGlmaWVyIGZyb20gcG9pbnRlciB0YXJnZXQgdHlwZSBbLVdkaXNjYXJkZWQtcXVhbGlm
aWVyc10KICAyMTAgfCAgICAgICAgICAgICAgICAgaCA9IG1lbWNocihoZXhjaGFycywgaGV4W3hd
LCBoZXhjaGFyc19zaXplKTsKICAgICAgfCAgICAgICAgICAgICAgICAgICBeCmYyZnNjcnlwdC5j
OjIxMzoxOTogd2FybmluZzogYXNzaWdubWVudCBkaXNjYXJkcyDigJhjb25zdOKAmSBxdWFsaWZp
ZXIgZnJvbSBwb2ludGVyIHRhcmdldCB0eXBlIFstV2Rpc2NhcmRlZC1xdWFsaWZpZXJzXQogIDIx
MyB8ICAgICAgICAgICAgICAgICBsID0gbWVtY2hyKGhleGNoYXJzLCBoZXhbeCArIDFdLCBoZXhj
aGFyc19zaXplKTsKICAgICAgfCAgICAgICAgICAgICAgICAgICBeCmYyZnNjcnlwdC5jOiBJbiBm
dW5jdGlvbiDigJhwYXJzZV9zYWx04oCZOgpmMmZzY3J5cHQuYzozNzE6Mjc6IHdhcm5pbmc6IGFz
c2lnbm1lbnQgZGlzY2FyZHMg4oCYY29uc3TigJkgcXVhbGlmaWVyIGZyb20gcG9pbnRlciB0YXJn
ZXQgdHlwZSBbLVdkaXNjYXJkZWQtcXVhbGlmaWVyc10KICAzNzEgfCAgICAgICAgICAgICAgICAg
ICAgICAgICBoID0gbWVtY2hyKGhleGNoYXJzLCAqY3ArKywgaGV4Y2hhcnNfc2l6ZSk7CiAgICAg
IHwgICAgICAgICAgICAgICAgICAgICAgICAgICBeCmYyZnNjcnlwdC5jOjM3MjoyNzogd2Fybmlu
ZzogYXNzaWdubWVudCBkaXNjYXJkcyDigJhjb25zdOKAmSBxdWFsaWZpZXIgZnJvbSBwb2ludGVy
IHRhcmdldCB0eXBlIFstV2Rpc2NhcmRlZC1xdWFsaWZpZXJzXQogIDM3MiB8ICAgICAgICAgICAg
ICAgICAgICAgICAgIGwgPSBtZW1jaHIoaGV4Y2hhcnMsICpjcCsrLCBoZXhjaGFyc19zaXplKTsK
ICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KClNpZ25lZC1vZmYtYnk6IEp1aHl1
bmcgUGFyayA8cWtyd25ndWQ4MjVAZ21haWwuY29tPgotLS0KIGZzY2svY29tcHJlc3MuYyAgIHwg
MiArLQogdG9vbHMvZjJmc2NyeXB0LmMgfCA0ICsrLS0KIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzY2svY29tcHJlc3MuYyBi
L2ZzY2svY29tcHJlc3MuYwppbmRleCBiMTVmMGE0MWM0NmUuLjUzMTRiNmI1MjAzNCAxMDA2NDQK
LS0tIGEvZnNjay9jb21wcmVzcy5jCisrKyBiL2ZzY2svY29tcHJlc3MuYwpAQCAtMTMzLDcgKzEz
Myw3IEBAIHN0YXRpYyBib29sIGV4dF9mb3VuZChjb25zdCBjaGFyICpleHQpCiAKIHN0YXRpYyBj
b25zdCBjaGFyICpnZXRfZXh0KGNvbnN0IGNoYXIgKnBhdGgpCiB7Ci0JY2hhciAqcCA9IHN0cnJj
aHIocGF0aCwgJy4nKTsKKwljb25zdCBjaGFyICpwID0gc3RycmNocihwYXRoLCAnLicpOwogCiAJ
cmV0dXJuIHAgPT0gTlVMTCA/IHBhdGggKyBzdHJsZW4ocGF0aCkgOiBwICsgMTsKIH0KZGlmZiAt
LWdpdCBhL3Rvb2xzL2YyZnNjcnlwdC5jIGIvdG9vbHMvZjJmc2NyeXB0LmMKaW5kZXggZDUyMjJm
YjQxMjFiLi4wMGM1OTNkNDViOWUgMTAwNjQ0Ci0tLSBhL3Rvb2xzL2YyZnNjcnlwdC5jCisrKyBi
L3Rvb2xzL2YyZnNjcnlwdC5jCkBAIC0yMDIsNyArMjAyLDcgQEAgc3RhdGljIGludCBoZXgyYnl0
ZShjb25zdCBjaGFyICpoZXgsIHNpemVfdCBoZXhfc2l6ZSwgdW5zaWduZWQgY2hhciAqYnl0ZXMs
CiAJCSAgICBzaXplX3QgYnl0ZXNfc2l6ZSkKIHsKIAlzaXplX3QgeDsKLQl1bnNpZ25lZCBjaGFy
ICpoLCAqbDsKKwljb25zdCB1bnNpZ25lZCBjaGFyICpoLCAqbDsKIAogCWlmIChoZXhfc2l6ZSAl
IDIpCiAJCXJldHVybiAtRUlOVkFMOwpAQCAtMzYwLDcgKzM2MCw3IEBAIHN0YXRpYyB2b2lkIHBh
cnNlX3NhbHQoY2hhciAqc2FsdF9zdHIsIGludCBmbGFncykKIAkJY3AgKz0gMjsKIAkJZ290byBz
YWx0X2Zyb21fZmlsZW5hbWU7CiAJfSBlbHNlIGlmIChzdHJuY21wKGNwLCAiMHgiLCAyKSA9PSAw
KSB7Ci0JCXVuc2lnbmVkIGNoYXIgKmgsICpsOworCQljb25zdCB1bnNpZ25lZCBjaGFyICpoLCAq
bDsKIAogCQljcCArPSAyOwogCQlpZiAoc3RybGVuKGNwKSAmIDEpCi0tIAoyLjU1LjAKCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1k
ZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQK
aHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1k
ZXZlbAo=
