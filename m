Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28283C624CE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KfDyfXJv7wR7bZO/v4TcL5IKxEju/qKeRP9HzFD4+to=; b=EhwFWBC3pnJpeQKq5F5uFY2xCP
	Tjs3+MSKdKyWuKRHW+8+JzRhq1E23/KJTASCzXSo7BIwb7o15XlrYZUt6ApqGGeteKrBGnWulWjnT
	WdZOimnbQz+f2U3o3lXTHV3VZMcIph/5Ov3PYLcY7wk0vSgf8u7q33O/4a3+lpecTB7o=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x12Il-0001Qi-QZ;
	Mon, 31 Aug 2026 13:43:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashal@kernel.org>) id 1x12Ik-0001QW-Rz
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 13:43:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FrC4tyM01XfC74y3iCYXDeh4k761i06gexhwjbMakV8=; b=X7x0og3bSJzy5XnB/aDi1DnQhS
 +u4XNgO0mtSyYEzdbMRlY3FaAw6Bszk4XbcIGCfKPN3zfU5APv9ZIt7Gr8KOf+WdKsIAS/p6O67s7
 9iX4u40mXmLVB+kzQ3RiLkt2pxvN1qjNNBJM+Q0LU9d9sv7M4y+OfTelducoIPY5rP6Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FrC4tyM01XfC74y3iCYXDeh4k761i06gexhwjbMakV8=; b=mALBPaQr3gwrG8Hw6Vr5mF/DWi
 7XEwfqv3kOvGEi+SgQ4mt8NkK02ru80f0YKGFGRRJBe1vyC8fZG/qZCI1Q+UrH3N1rSIgtcgVOw2/
 U6iwxyseThgRty4Nd+R0nbfXeDLa7XCMU5+YRy+xXOX+Kmq1+vbYGwkesbsjETjfxr+M=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x12Ik-00035W-4z for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 13:43:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 91E7160267;
 Mon, 31 Aug 2026 13:43:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624371F00ACF;
 Mon, 31 Aug 2026 13:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788183828;
 bh=FrC4tyM01XfC74y3iCYXDeh4k761i06gexhwjbMakV8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hMjBNYCQ+/X9I2qHIroHfyPBdwTvKul9ae7+zZP4u/NqxFW9r3SoXY2c9OTMMVJdE
 X0fgBDtQa38fBXAXJ3Rsloi/U9yYPSy1neGNeUOGT2nULDH/xrdvJodcM9q6/o40oi
 sEY1WacIi8zFC3cWOHfNBJz7tDPdU32yG0BY9T2ZLi+tkxp3vrGmOSTQIzMiWRDU1Y
 s8bERlvjqN411bHzMgF9R1SG40mWUVxbbB7mPRG6EICTJVicusIhkHKOz4uyljOVaJ
 +qlNNMP3GREx6oyH7FUYnME4Z/rEc1JGgDTyGC5Dii9I1JLqTMFRddVlKKzgaAxtGu
 pHi7OsnuZAP0A==
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Date: Mon, 31 Aug 2026 09:25:57 -0400
Message-ID: <20260831133314.4125787-329-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831133314.4125787-1-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.48
X-Headers-End: 1x12Ik-00035W-4z
Subject: [f2fs-dev] [PATCH AUTOSEL 6.18] f2fs: optimize representative type
 determination in GC
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
From: Sasha Levin via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Sasha Levin <sashal@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Daeho Jeong <daehojeong@google.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

RnJvbTogRGFlaG8gSmVvbmcgPGRhZWhvamVvbmdAZ29vZ2xlLmNvbT4KClsgVXBzdHJlYW0gY29t
bWl0IDVkZmI3NjgzMjZiOTVjNmRkNjU1NGYzNGRlYzcxYjQ0YTAxYTBiYzggXQoKSW4gbGFyZ2Ug
c2VjdGlvbiBtb2RlLCBkb19nYXJiYWdlX2NvbGxlY3QoKSBwcmV2aW91c2x5IGRldGVybWluZWQg
dGhlCnNlY3Rpb24ncyByZXByZXNlbnRhdGl2ZSB0eXBlIGJ5IGxvb2tpbmcgb25seSBhdCB0aGUg
Zmlyc3Qgc2VnbWVudCBvZgp0aGUgc2VjdGlvbi4gSG93ZXZlciwgaWYgZGF0YSB3YXMgZnN5bmNl
ZCBpbnRvIGFuIGFyZWEgcHJldmlvdXNseSB1c2VkCmFzIGEgbm9kZSBzZWN0aW9uLCBhbmQgdGhp
cyBhcmVhIGlzIHJlY292ZXJlZCBkdXJpbmcgcm9sbC1mb3J3YXJkCnJlY292ZXJ5IGFmdGVyIHN1
ZGRlbiBwb3dlciBvZmYgKFNQTyksIEdDIHdvdWxkIGluY29ycmVjdGx5IGFzc3VtZSB0aGUKc2Vj
dGlvbidzIHR5cGUgYmFzZWQgb24gYW4gZW1wdHkgb3Igb2Jzb2xldGUgZmlyc3Qgc2VnbWVudC4g
VGhpcyBjYXVzZWQKdGhlIHJlY292ZXJlZCBkYXRhIHNlZ21lbnQgdG8gYmUgbWlzdW5kZXJzdG9v
ZCBhcyBiZWluZyBzdHVjayBpbnNpZGUgYQpub2RlIHNlY3Rpb24sIHRyaWdnZXJpbmcgZmFsc2Ug
aW5jb25zaXN0ZW5jeSBwYW5pY3MgKEluY29uc2lzdGVudApzZWdtZW50IHR5cGUgaW4gU1NBIGFu
ZCBTSVQpIGFuZCBzdWJzZXF1ZW50IG1vdW50IGZhaWx1cmVzLgoKVGhpcyBwYXRjaCBvcHRpbWl6
ZXMgZG9fZ2FyYmFnZV9jb2xsZWN0KCkgdG8gZGV0ZXJtaW5lIHRoZSBzZWN0aW9uJ3MKcmVwcmVz
ZW50YXRpdmUgdHlwZSBieSBpZGVudGlmeWluZyB0aGUgZmlyc3Qgc2VnbWVudCB0aGF0IGFjdHVh
bGx5CmNvbnRhaW5zIHZhbGlkIGJsb2NrcyAodmFsaWRfYmxvY2tzID4gMCkgZHVyaW5nIHRoZSBt
YWluIEdDIGxvb3AuIFRoaXMKZWxpbWluYXRlcyBmYWxzZSBhbGFybXMgZnJvbSBlbXB0eS9vYnNv
bGV0ZSBsZWFkaW5nIHNlZ21lbnRzIHdoaWxlCm1haW50YWluaW5nIHN0cmljdCBzZWN0aW9uLWxl
dmVsIHR5cGUgY29uc2lzdGVuY3kgY2hlY2tzIGZvciBnZW51aW5lCmNvcnJ1cHRpb24uCgpTaWdu
ZWQtb2ZmLWJ5OiBEYWVobyBKZW9uZyA8ZGFlaG9qZW9uZ0Bnb29nbGUuY29tPgpTaWduZWQtb2Zm
LWJ5OiBKYWVnZXVrIEtpbSA8amFlZ2V1a0BrZXJuZWwub3JnPgpTaWduZWQtb2ZmLWJ5OiBTYXNo
YSBMZXZpbiA8c2FzaGFsQGtlcm5lbC5vcmc+Ci0tLQoKTExNIEdlbmVyYXRlZCBleHBsYW5hdGlv
bnMsIG1heSBiZSBjb21wbGV0ZWx5IGJvZ3VzOgoKVGhlIGJhY2tncm91bmQgZ2l0IHNlYXJjaGVz
IGZpbmlzaGVkIGFuZCBsaW5lIHVwIHdpdGggdGhlIGVhcmxpZXIKYW5hbHlzaXM6CgotICoqYG9y
aWdpbi9tYXN0ZXJgKiogaGFzIHRoZSBmaXggYXMgYDVkZmI3NjgzMjZiOTVgICgiZjJmczogb3B0
aW1pemUKICByZXByZXNlbnRhdGl2ZSB0eXBlIGRldGVybWluYXRpb24gaW4gR0MiKSwgbWVyZ2Vk
IHZpYSB0aGUgZjJmcy0KICBmb3ItNy4xLXJjMSB0YWcuCi0gKipDdXJyZW50IEhFQUQgKHY2LjE4
LjQ0KSoqIGRvZXMgbm90IGNvbnRhaW4gaXQg4oCUIHN1YmplY3QgZ3JlcCBvbiBIRUFECiAgcmV0
dXJuZWQgbm90aGluZywgYW5kIHJlY2VudCBgZnMvZjJmcy9nYy5jYCBoaXN0b3J5IHNob3dzIG5v
IHNpZ24gb2YKICB0aGlzIHBhdGNoLgoKVGhhdCBzdXBwb3J0cyB0aGUgKipZRVMqKiBiYWNrcG9y
dCByZWNvbW1lbmRhdGlvbiBmb3IgdGhpcyA2LjE4LnkgdHJlZToKdGhlIGJ1ZyBpcyBzdGlsbCBw
cmVzZW50IGhlcmUsIHRoZSBmaXggaXMgb24gbWFpbmxpbmUsIGFuZCBpdCBhcHBsaWVzCmNsZWFu
bHkuCgogZnMvZjJmcy9nYy5jIHwgMTEgKysrKysrKystLS0KIDEgZmlsZSBjaGFuZ2VkLCA4IGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvZjJmcy9nYy5jIGIv
ZnMvZjJmcy9nYy5jCmluZGV4IDNkNDFjNjM0OGIzYzEuLmU1NmM3Y2NlY2FmZjUgMTAwNjQ0Ci0t
LSBhL2ZzL2YyZnMvZ2MuYworKysgYi9mcy9mMmZzL2djLmMKQEAgLTE3NjksOSArMTc2OSw4IEBA
IHN0YXRpYyBpbnQgZG9fZ2FyYmFnZV9jb2xsZWN0KHN0cnVjdCBmMmZzX3NiX2luZm8gKnNiaSwK
IAl1bnNpZ25lZCBpbnQgZW5kX3NlZ25vID0gc3RhcnRfc2Vnbm8gKyBTRUdTX1BFUl9TRUMoc2Jp
KTsKIAl1bnNpZ25lZCBpbnQgc2VjX2VuZF9zZWdubzsKIAlpbnQgc2VnX2ZyZWVkID0gMCwgbWln
cmF0ZWQgPSAwOwotCXVuc2lnbmVkIGNoYXIgdHlwZSA9IElTX0RBVEFTRUcoZ2V0X3NlZ19lbnRy
eShzYmksIHNlZ25vKS0+dHlwZSkgPwotCQkJCQkJU1VNX1RZUEVfREFUQSA6IFNVTV9UWVBFX05P
REU7Ci0JdW5zaWduZWQgY2hhciBkYXRhX3R5cGUgPSAodHlwZSA9PSBTVU1fVFlQRV9EQVRBKSA/
IERBVEEgOiBOT0RFOworCXVuc2lnbmVkIGNoYXIgdHlwZTsKKwl1bnNpZ25lZCBjaGFyIGRhdGFf
dHlwZTsKIAlpbnQgc3VibWl0dGVkID0gMCwgc3VtX2Jsa19jbnQ7CiAKIAlpZiAoX19pc19sYXJn
ZV9zZWN0aW9uKHNiaSkpIHsKQEAgLTE4NzAsNiArMTg2OSwxMiBAQCBzdGF0aWMgaW50IGRvX2dh
cmJhZ2VfY29sbGVjdChzdHJ1Y3QgZjJmc19zYl9pbmZvICpzYmksCiAJCQkJCW1pZ3JhdGVkID49
IHNiaS0+bWlncmF0aW9uX2dyYW51bGFyaXR5KQogCQkJCWNvbnRpbnVlOwogCisJCQlpZiAobWln
cmF0ZWQgPT0gMCkgeworCQkJCXR5cGUgPSBJU19EQVRBU0VHKGdldF9zZWdfZW50cnkoc2JpLCBj
dXJfc2Vnbm8pLT50eXBlKSA/CisJCQkJCQkJU1VNX1RZUEVfREFUQSA6IFNVTV9UWVBFX05PREU7
CisJCQkJZGF0YV90eXBlID0gKHR5cGUgPT0gU1VNX1RZUEVfREFUQSkgPyBEQVRBIDogTk9ERTsK
KwkJCX0KKwogCQkJc3VtID0gU1VNX0JMS19QQUdFX0FERFIoc2JpLCBzdW1fZm9saW8sIGN1cl9z
ZWdubyk7CiAJCQlpZiAodHlwZSAhPSBHRVRfU1VNX1RZUEUoc3VtX2Zvb3RlcihzYmksIHN1bSkp
KSB7CiAJCQkJZjJmc19lcnIoc2JpLCAiSW5jb25zaXN0ZW50IHNlZ21lbnQgKCV1KSB0eXBlICIK
LS0gCjIuNTMuMAoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3Rz
LnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0
aW5mby9saW51eC1mMmZzLWRldmVsCg==
