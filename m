Return-Path: <SRS0=TsZy=54=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F23DC2D0EC
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 12 Apr 2020 21:35:19 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71B7E206C3;
	Sun, 12 Apr 2020 21:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="RyuD2j7L";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="SS1K8/IY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="ESxh/xXZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71B7E206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=disroot.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jNkG4-0004Xj-5c; Sun, 12 Apr 2020 21:35:16 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ericonr@disroot.org>) id 1jNkG2-0004XY-4W
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 12 Apr 2020 21:35:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Mime-Version
 :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hR/LeXQys9LIWvm1QUEpCq6ma6Ui1J8OrD6zRWGDGgM=; b=RyuD2j7L1l62C7k8Vo1DM5uqLu
 aORcKM+xnsJw3yVQn0W0EAs/DiiGUTzwKNeknYtwd6LVwNcYiRop2Tv77t0BvYOhwScU7ODC6vH/V
 qZa8OQv2qKWbhWB9Gglxb7ZSp/w591/YQvrb6ocp44BMkrQqD5qOz7zAnFP9KvK2ZBRk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Mime-Version:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=hR/LeXQys9LIWvm1QUEpCq6ma6Ui1J8OrD6zRWGDGgM=; b=S
 S1K8/IYnRWe/QUdFeZRwjuD3viEcmy86mN3Ek4ZFsWF5WxCtyVS5lnw+8Da+MmAGuBOCl9FtbMoem
 x5Frhh4Cscs7akJLc2URG8XuG2WRSCo6O+SIBEDOXikPU3fjJEc2sHqo6qe021kOQMA+3zb2TORQ1
 8dFzaXuDcu3tWgSY=;
Received: from knopi.disroot.org ([178.21.23.139])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jNkFz-00Dn9i-Ij
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 12 Apr 2020 21:35:14 +0000
Received: from localhost (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 6A5862084E;
 Sun, 12 Apr 2020 23:35:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at disroot.org
Received: from knopi.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wMPV0JA6MDWh; Sun, 12 Apr 2020 23:35:02 +0200 (CEST)
From: =?UTF-8?q?=C3=89rico=20Nogueira?= <ericonr@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1586727302; bh=RTmUAF0uoxV3lAbAtVW9rWF9zBweUJS7VK7Bw9anyNw=;
 h=From:To:Cc:Subject:Date;
 b=ESxh/xXZZNPalgAjdjROYqGDdZnencICTnywBTNyOFqhBjXghJpO1xNWBeN+CTVNv
 l52qj/a4Rk+pXocbcGseoW0TRq7C2kK9WJC5D9KCHrIlN1M+hjPqn14Zdt/W2zeSju
 GVMkb8jU+qIUgzCK9Uknetdh0zk8EIfA9aG6aiYrJ2xgJcCF+m/gt9NFWjIL6ettpy
 xKNzC5VJw3FKH21x9h1HQNUVW5z9zc1Mz0iSjVV5TxBDJD5s1TRYhh4Ar9qKOIdcpO
 Bkdqdh5rG8f+BGf7iDdyl/KX6wUZS36Ik3dGuEONk2p66SrLK3dash/Q5HweFVY/eB
 +VWH9JK5HYYmg==
To: linux-f2fs-devel@lists.sourceforge.net
Date: Sun, 12 Apr 2020 18:34:34 -0300
Message-Id: <20200412213435.179726-1-ericonr@disroot.org>
Mime-Version: 1.0
X-Headers-End: 1jNkFz-00Dn9i-Ij
Subject: [f2fs-dev] [PATCH 0/1] mkfs.f2fs: update manual and help message
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

SGV5IHRoZXJlISBUaGlzIHBhdGNoIGFpbXMgdG8gaW1wcm92ZSB0aGVkIGRvY3VtZW50YXRpb24g
b2YgdGhlCm1rZnMuZjJmcyB0b29sLiBCYXNlZCBvbiBmZWVkYmFjayBJIHJlY2VpdmUgYWJvdXQg
aXQsIEkgd2lsbCBhbHNvIG1ha2UKY2hhbmdlcyB0byB0aGUgZnNjay5mMmZzIG1hbnVhbCBhbmQg
aGVscCBtZXNzYWdlcy4KCsOJcmljbyBOb2d1ZWlyYSAoMSk6CiAgbWtmcy5mMmZzOiB1cGRhdGUg
bWFudWFsIGFuZCBoZWxwIG1lc3NhZ2UKCiBtYW4vbWtmcy5mMmZzLjggICAgICAgICB8IDE0MSAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tCiBta2ZzL2YyZnNfZm9ybWF0
X21haW4uYyB8ICAxMiArKy0tCiAyIGZpbGVzIGNoYW5nZWQsIDEyNCBpbnNlcnRpb25zKCspLCAy
OSBkZWxldGlvbnMoLSkKCi0tIAoyLjI2LjAKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgt
ZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
