Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09113C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 12 Dec 2021 09:17:01 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mwKyZ-00065f-Nm; Sun, 12 Dec 2021 09:16:59 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1mwKyT-00065R-5w
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 12 Dec 2021 09:16:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Whur3XxZ3oeuWOH1h0ikM5pHhtlniDvAzAfGzVLGXoM=; b=jtEqsN3QH/sRujeaFc4qq+/jUY
 tyCRovXHyBUbGKG4Xoe88U1maJc0fivRV6foUnI2ZPMoPs109/8pnmD/0dP4tIDtCSvBqq05jAwAN
 Gsim1fNsjHyYB/GMZ0Yvyf1XXmIt+PbzGsDEn2GX5pdTntkqQeXfT/D/pZhNFboaNhmU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Whur3XxZ3oeuWOH1h0ikM5pHhtlniDvAzAfGzVLGXoM=; b=g
 J+0skFO12INPwXWFnoQ9p8r0hh3FCdTFk1j0TTrJfYpQ3h9tXYt+Sb6IRVh3Nh9rYrzrkK7FUR6Id
 8n9MRllSVyjTfphlwaaEf0Xi4mXCtk3+U3SqyyQLjWyAxo4/fitV0osi/gEKjpSJm0mPwb3k56MzQ
 olkWcKn9+tv9dAwI=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mwKyS-00CvXJ-8n
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 12 Dec 2021 09:16:53 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 81A1ACE0B0D;
 Sun, 12 Dec 2021 09:16:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F02AC341C6;
 Sun, 12 Dec 2021 09:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639300595;
 bh=FcCfq4bNjl8T6b/+8viEc5WUfvmEh89NrvoiU1a3sYo=;
 h=From:To:Cc:Subject:Date:From;
 b=nSylLWdl/51/bEM84CdSYtjLlUdiW90rNo5EfAtj691K6sfdOePWpG6Z8ekFpGEyE
 /xHtJVf+ui8eTKgyk3u6m8CK1EkoSA8R3xpyCX/dFa/Tnj4E4utDyqLaGi9uQ8Qkvu
 N6qCSEP4MR3oE7uXW4TOczO5b1FeJmxaQU7GZpRQgzDxrqvoGGqQVpwb+dYjjvxc3Q
 E0FmRVL/ICLoC6IWHg00wdqNNSA9zRjVO+R9eMsYKj+eeLlW/UeztUCtNof5Wh1ei3
 jvA3+EA5Ab7wRVqYUzAWrJgmrufy6MhvcYi4sYB2WpwulS+z5HBAIrSycwzMYWaW2j
 R43Bffk254rKQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Sun, 12 Dec 2021 17:16:30 +0800
Message-Id: <20211212091630.6325-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Headers-End: 1mwKyS-00CvXJ-8n
Subject: [f2fs-dev] [PATCH v3] f2fs: fix to do sanity check on last xattr
 entry in __f2fs_setxattr()
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
Cc: Wenqing Liu <wenqingliu0120@gmail.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

QXMgV2VucWluZyBMaXUgcmVwb3J0ZWQgaW4gYnVnemlsbGE6CgpodHRwczovL2J1Z3ppbGxhLmtl
cm5lbC5vcmcvc2hvd19idWcuY2dpP2lkPTIxNTIzNQoKLSBPdmVydmlldwpwYWdlIGZhdWx0IGlu
IGYyZnNfc2V0eGF0dHIoKSB3aGVuIG1vdW50IGFuZCBvcGVyYXRlIG9uIGNvcnJ1cHRlZCBpbWFn
ZQoKLSBSZXByb2R1Y2UKdGVzdGVkIG9uIGtlcm5lbCA1LjE2LXJjMywgNS4xNS5YIHVuZGVyIHJv
b3QKCjEuIHVuemlwIHRtcDcuemlwCjIuIC4vc2luZ2xlLnNoIGYyZnMgNwoKU29tZXRpbWVzIG5l
ZWQgdG8gcnVuIHRoZSBzY3JpcHQgc2V2ZXJhbCB0aW1lcwoKLSBLZXJuZWwgZHVtcApsb29wMDog
ZGV0ZWN0ZWQgY2FwYWNpdHkgY2hhbmdlIGZyb20gMCB0byAxMzEwNzIKRjJGUy1mcyAobG9vcDAp
OiBGb3VuZCBuYXRfYml0cyBpbiBjaGVja3BvaW50CkYyRlMtZnMgKGxvb3AwKTogTW91bnRlZCB3
aXRoIGNoZWNrcG9pbnQgdmVyc2lvbiA9IDc1NDhjMmVlCkJVRzogdW5hYmxlIHRvIGhhbmRsZSBw
YWdlIGZhdWx0IGZvciBhZGRyZXNzOiBmZmZmZTQ3YmM3MTIzZjQ4ClJJUDogMDAxMDprZnJlZSsw
eDY2LzB4MzIwCkNhbGwgVHJhY2U6CiBfX2YyZnNfc2V0eGF0dHIrMHgyYWEvMHhjMDAgW2YyZnNd
CiBmMmZzX3NldHhhdHRyKzB4ZmEvMHg0ODAgW2YyZnNdCiBfX2YyZnNfc2V0X2FjbCsweDE5Yi8w
eDMzMCBbZjJmc10KIF9fdmZzX3JlbW92ZXhhdHRyKzB4NTIvMHg3MAogX192ZnNfcmVtb3ZleGF0
dHJfbG9ja2VkKzB4YjEvMHgxNDAKIHZmc19yZW1vdmV4YXR0cisweDU2LzB4MTAwCiByZW1vdmV4
YXR0cisweDU3LzB4ODAKIHBhdGhfcmVtb3ZleGF0dHIrMHhhMy8weGMwCiBfX3g2NF9zeXNfcmVt
b3ZleGF0dHIrMHgxNy8weDIwCiBkb19zeXNjYWxsXzY0KzB4MzcvMHhiMAogZW50cnlfU1lTQ0FM
TF82NF9hZnRlcl9od2ZyYW1lKzB4NDQvMHhhZQoKVGhlIHJvb3QgY2F1c2UgaXMgaW4gX19mMmZz
X3NldHhhdHRyKCksIHdlIG1pc3NlZCB0byBkbyBzYW5pdHkgY2hlY2sgb24KbGFzdCB4YXR0ciBl
bnRyeSwgcmVzdWx0IGluIG91dC1vZi1ib3VuZCBtZW1vcnkgYWNjZXNzIGR1cmluZyB1cGRhdGlu
ZwppbmNvbnNpc3RlbnQgeGF0dHIgZGF0YSBvZiB0YXJnZXQgaW5vZGUuCgpBZnRlciB0aGUgZml4
LCBpdCBjYW4gZGV0ZWN0IHN1Y2ggeGF0dHIgaW5jb25zaXN0ZW5jeSBhcyBiZWxvdzoKCkYyRlMt
ZnMgKGxvb3AxMSk6IGlub2RlICg3KSBoYXMgaW52YWxpZCBsYXN0IHhhdHRyIGVudHJ5LCBlbnRy
eV9zaXplOiA2MDY3NgpGMkZTLWZzIChsb29wMTEpOiBpbm9kZSAoOCkgaGFzIGNvcnJ1cHRlZCB4
YXR0cgpGMkZTLWZzIChsb29wMTEpOiBpbm9kZSAoOCkgaGFzIGNvcnJ1cHRlZCB4YXR0cgpGMkZT
LWZzIChsb29wMTEpOiBpbm9kZSAoOCkgaGFzIGludmFsaWQgbGFzdCB4YXR0ciBlbnRyeSwgZW50
cnlfc2l6ZTogNDc3MzYKCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnClJlcG9ydGVkLWJ5OiBX
ZW5xaW5nIExpdSA8d2VucWluZ2xpdTAxMjBAZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBDaGFv
IFl1IDxjaGFvQGtlcm5lbC5vcmc+Ci0tLQp2MzoKLSBmaXggY29tcGlsZSB3YXJuaW5nOgp3YXJu
aW5nOiBmb3JtYXQg4oCYJXXigJkgZXhwZWN0cyBhcmd1bWVudCBvZiB0eXBlIOKAmHVuc2lnbmVk
IGludOKAmSwgYnV0IGFyZ3VtZW50IDQgaGFzIHR5cGUg4oCYbG9uZyB1bnNpZ25lZCBpbnTigJkg
Wy1XZm9ybWF0PV0KIGZzL2YyZnMveGF0dHIuYyB8IDExICsrKysrKysrKystCiAxIGZpbGUgY2hh
bmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2ZzL2Yy
ZnMveGF0dHIuYyBiL2ZzL2YyZnMveGF0dHIuYwppbmRleCBlMzQ4ZjMzYmNiMmIuLjc5N2FjNTA1
YTA3NSAxMDA2NDQKLS0tIGEvZnMvZjJmcy94YXR0ci5jCisrKyBiL2ZzL2YyZnMveGF0dHIuYwpA
QCAtNjg0LDggKzY4NCwxNyBAQCBzdGF0aWMgaW50IF9fZjJmc19zZXR4YXR0cihzdHJ1Y3QgaW5v
ZGUgKmlub2RlLCBpbnQgaW5kZXgsCiAJfQogCiAJbGFzdCA9IGhlcmU7Ci0Jd2hpbGUgKCFJU19Y
QVRUUl9MQVNUX0VOVFJZKGxhc3QpKQorCXdoaWxlICghSVNfWEFUVFJfTEFTVF9FTlRSWShsYXN0
KSkgeworCQlpZiAoKHZvaWQgKikobGFzdCkgKyBzaXplb2YoX191MzIpID4gbGFzdF9iYXNlX2Fk
ZHIgfHwKKwkJCSh2b2lkICopWEFUVFJfTkVYVF9FTlRSWShsYXN0KSA+IGxhc3RfYmFzZV9hZGRy
KSB7CisJCQlmMmZzX2VycihGMkZTX0lfU0IoaW5vZGUpLCAiaW5vZGUgKCVsdSkgaGFzIGludmFs
aWQgbGFzdCB4YXR0ciBlbnRyeSwgZW50cnlfc2l6ZTogJXp1IiwKKwkJCQkJaW5vZGUtPmlfaW5v
LCBFTlRSWV9TSVpFKGxhc3QpKTsKKwkJCXNldF9zYmlfZmxhZyhGMkZTX0lfU0IoaW5vZGUpLCBT
QklfTkVFRF9GU0NLKTsKKwkJCWVycm9yID0gLUVGU0NPUlJVUFRFRDsKKwkJCWdvdG8gZXhpdDsK
KwkJfQogCQlsYXN0ID0gWEFUVFJfTkVYVF9FTlRSWShsYXN0KTsKKwl9CiAKIAluZXdzaXplID0g
WEFUVFJfQUxJR04oc2l6ZW9mKHN0cnVjdCBmMmZzX3hhdHRyX2VudHJ5KSArIGxlbiArIHNpemUp
OwogCi0tIAoyLjMyLjAKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBs
aXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMv
bGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
