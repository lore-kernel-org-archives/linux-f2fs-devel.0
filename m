Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1127C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 19 Mar 2022 13:12:23 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nVYsZ-0003sx-4U; Sat, 19 Mar 2022 13:12:21 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mudrunka@spoje.net>) id 1nVYsX-0003sq-TT
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 19 Mar 2022 13:12:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-ID:From:Date:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:To:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+zJvzCwNgpyaM3SjrBRBnJiMehdL7esgoW5OmUaGwe4=; b=OvPscwsR/TRiZxpiLF1HL+lQpk
 CpLiMD+tWkoVIUpRHwvu4/McRDTL+aLFcfi8AQS9s1TWD6+vlKkRNwHZveq7VwIFpgUrbOgmLIa1W
 xkw6dn9yOjNgPqWyqcCivg1OGr3Avv28dGF+dO2EMgnAQQ7mpg+JAMQXvRIDFo/ri7iM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-ID:From:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Subject:To:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+zJvzCwNgpyaM3SjrBRBnJiMehdL7esgoW5OmUaGwe4=; b=S
 +X0jAZdOy5y1Y7wU9Ppbnv8/+1dPncQIcvv9pqPCwVoxRi/LEopxsGJkmsKNFlWYT6I/UE/E781Un
 R/pM98caUO44NjvheNJ7tVngSCrevoU5XE5lhu4vQ0g6590q2TMBzgaDwPtMVVehKZaMUJwFUxqFf
 83KwuvuiwFQw+lyw=;
Received: from mail.spoje.net ([82.100.58.2])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtp (Exim 4.94.2)
 id 1nVYsS-0006Ye-T7
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 19 Mar 2022 13:12:20 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail.spoje.net (Postfix) with ESMTP id 44274B6BE6F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 19 Mar 2022 13:55:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=spoje.net;
 s=spojemail; t=1647694529;
 bh=z6ElUe8gwRYzcJ2gyMDrHHvObg/uji0fp2xQ0JCQy6M=;
 h=To:Subject:Date:From:From;
 b=EdMkbFd5lz+Fupma3ZZgM4UA5MVeyj4aOW9HlHuUNLa7IiYaO9CfwtY3lJNAPMqzX
 gjX3JoZD8zPoL518R6gboSnZto1YhHCU9taEB68zMvaUNE8/mVXTGJomyhTe8zigbp
 zMVUq+Bh2rEMKmJvERyVhQrjqy+zraHF25AeVihY=
X-Virus-Scanned: Debian amavisd-new at mail.spoje.net
Authentication-Results: mail.spoje.net (amavisd-new); dkim=pass (1024-bit key)
 header.d=spoje.net
Received: from mail.spoje.net ([127.0.0.1])
 by localhost (mail.spoje.net [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rnPex0tQ798i
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 19 Mar 2022 13:55:27 +0100 (CET)
Received: by mail.spoje.net (Postfix, from userid 33)
 id 23F6AB6C0C3; Sat, 19 Mar 2022 13:55:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=spoje.net;
 s=spojemail; t=1647694527;
 bh=z6ElUe8gwRYzcJ2gyMDrHHvObg/uji0fp2xQ0JCQy6M=;
 h=To:Subject:Date:From:From;
 b=MPACySe+PWioaRjYVjdfxwQN0LU0yrJ1IxdY2I6pPIQmtWdVxo9w8qouXsgQE0Bqq
 /7MzbEEnAgRb1BoGFKp1w9mjRNceh5F4nOX9taRXUzg4gwO3x/TrWCTwPGSxxNQoMr
 Sq11wXNf5vapn1rLpzLaMTUvwCKKv1F2TpMMErbg=
To: linux-f2fs-devel@lists.sourceforge.net
X-PHP-Originating-Script: 0:rcube.php
MIME-Version: 1.0
Date: Sat, 19 Mar 2022 13:55:27 +0100
From: Tomas Mudrunka <mudrunka@spoje.net>
Organization: SPOJE.NET s.r.o.
Message-ID: <f4e22b0dff793f75b5c37a170acba03c@spoje.net>
X-Sender: mudrunka@spoje.net
User-Agent: Roundcube Webmail/1.2.3
X-Headers-End: 1nVYsS-0006Ye-T7
Subject: [f2fs-dev] Populate f2fs with files during mkfs.f2fs
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

SGVsbG8sCmkndmUgbm90aWNlZCB0aGF0IG1rZnMuZjJmcyBkb2VzIG5vdCBhbGxvdyBmaWxlcyB0
byBiZSBjb3BpZWQgdG8gCmZpbGVzeXN0ZW0gZHVyaW5nIGZvcm1hdGluZyBieSBta2ZzLmYyZnMu
CkRvIHlvdSB0aGluayBpdCB3b3VsZCBiZSBoYXJkIHRvIGFkZCBzdWNoIGZlYXR1cmU/CgpJIHVu
ZGVyc3RhbmQgdGhhdCB0aGlzIG1pZ2h0IGJlIGEgd2VpcmQgcmVxdWVzdCB3aGljaCBpbiBzb21l
IHNlbnNlIApkZWZpZXMgdGhlIGRlZmluaXRpb24gb2YgZmlsZXN5c3RlbSBmb3JtYXRpbmcgcHJv
Y2Vzcy4gQnV0IHRoZXJlIGFyZSAKYWxzbyBzb21lIGFyZ3VtZW50cyBmb3IgdGhpcyBjYXNlLgoK
SW4gdGhlIHdvcmxkIG9mIGVtYmVkZGVkIGRldmVsb3BtZW50IHdlIG9mdGVuIG5lZWQgdG8gYnVp
bGQgZmlybXdhcmUgCmltYWdlcyB0byBiZSBmbGFzaGVkIGludG8gdGhlIGRldmljZS4gQW5kIEYy
RlMgaXMgb25lIG9mIHRoZSBiZXN0IHN1aXRlZCAKZmlsZXN5c3RlbXMgZm9yIGVtYmVkZGVkIGFu
ZCBwZXJoYXBzIHRoZSBvbmUgYmVzdCBmb3IgbWFuYWdlZCBmbGFzaC4gU28gCndlIG5hdHVyYWx5
IHdhbnQgdG8gdXNlIGl0IGFuZCBidWlsZCBpbnRvIG91ciBmdyBpbWFnZXMuIEhvd2V2ZXIgdG8g
CmJ1aWxkIHN1Y2ggaW1hZ2UgaSBuZWVkIHRvIGNyZWF0ZSBmMmZzIGltYWdlLCBmb3JtYXQgaXQg
YW5kIHRoZW4gbW91bnQgCml0IHVzaW5nIGxvb3BiYWNrLCBjb3B5IGRhdGEgdG8gaXQsIHVubW91
bnQsIHN5bmMsIGhhbmRsZSBlcnJvcnMsIGV0Yy4uLiAKQW5kIHdlIGhhdmUgaHVnZSBtYWtlZmls
ZXMgb3Igc3R1ZmYgbGlrZSBnZW5pbWFnZSwgdG8gcHV0IGFsbCB0aGUgaW1hZ2UgCnBhcnRpdGlv
bnMgYW5kIGJvb3Rsb2FkZXJzIGFuZCBldmVyeXRoaW5nIHRvZ2V0aGVyLiBJdCBqdXN0IGFkZHMg
cXVpdGUgCmNvbXBsZXhpdHkgdG8gdGhlIGVtYmVkZGVkIGJ1aWxkIHN5c3RlbXMuCgpUdXJucyBv
dXQgdGhhdCBxdWl0ZSBmZXcgZmlsZXN5c3RlbXMgYWxyZWFkeSBoYXZlIHRoaXMgZmVhdHVyZSB0
byAKc2ltcGxpZnkgY3JlYXRpbmcgZmlsZXN5c3RlbSBpbWFnZXMgd2l0aG91dCBuZWVkIGZvciBt
b3VudGluZyBvciByb290IApwZXJtaXNzaW9uczoKCm1rZnMuZXh0NCAtZCAuL2lucHV0X2RpcmVj
dG9yeQpta2ZzLnViaWZzIC1kIC4vaW5wdXRfZGlyZWN0b3J5Cm1rZnMuamZmczIgLWQgLi9pbnB1
dF9kaXJlY3RvcnkKbWtjcmFtZnMgKG9idmlvdXNseSkKbWtzcXVhc2hmcyAob2J2aW91c2x5KQoK
d291bGQgeW91IHBsZWFzZSBjb25zaWRlciBhZGRpbmcgc3VjaCBmZWF0dXJlIGFzIHdlbGw/CgpU
aGFuayB5b3UKCi0tIApTIHBvemRyYXZlbQpCZXN0IHJlZ2FyZHMKICAgICAgVG9tw6HFoSBNdWRy
dcWIa2EgLSBTUE9KRS5ORVQgcy5yLm8uCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJm
cy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5u
ZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
