Return-Path: <SRS0=A+6L=NE=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C91CC4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 13 Aug 2021 14:41:37 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C33B60EE0;
	Fri, 13 Aug 2021 14:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4C33B60EE0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mEYNM-00045c-SG; Fri, 13 Aug 2021 14:41:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1mEYNC-00045Q-R9
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Aug 2021 14:41:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tPojTslHGSEkId3+CbKi+ufCww34cSFX233jTsnoW5k=; b=FSYA37SbpY6hnn3ltfxWZu06Ze
 Y30lCfjuR9Cq5eeqQbr0KR+tIi+TIW8+Ls92iVfHqeKPoRmPiaGuAtjmnnrKcVY7TtnsPnTioxabY
 m5bGYhZEzdjCRKn9MVutVccSgvJafHPDSqOivzzcAsmtWUPdulltZftGD58mrljKZirA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tPojTslHGSEkId3+CbKi+ufCww34cSFX233jTsnoW5k=; b=Vt+xRYoZltJyvIwwne3Sf2lb8z
 Ph+bfNAD2xtvcxbhHdfFYmxUyLx8Oo4rqHuWENuDl6L1cNU0+fDhb/UTYYgRGRIPJMpP37Hioh1Ye
 V/AbLfSAXwDOMMBRlumK4nrT2bjzZYtrPSV5IEEzrgUJuvZQkvgvnISyQKUxJ6553DcA=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mEYMz-005Fxg-C0
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Aug 2021 14:41:23 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7576360C41;
 Fri, 13 Aug 2021 14:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628865667;
 bh=lTE5dn1H2YpYJhp+KIjBVxOkkJJGTQc9GEOAL7tSiwA=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=H2gjhKOwV+yFuZJQFg7xBJnDa37RmRuz0bql3OAK8punjgpTtBjc3R37ZmmYx3zA4
 QM9TZIBsDpfTZZs5p67PmaU6eaAt4iwLm9L1Y7BysAC71YITQpztblqiONVMYZ3h93
 EQMW5pW17PsPoTBmMpkfHNDG+boc63cX8P44m8/zbPcvNwVzfh6+snAVoOQiUnAEW2
 RyS+0r68PZfxMZ9ouOWcPtO/Px8nLOJZ5u2G8T+McY/F8492T2bZmWMS1r+e0iJGNC
 XKRHLrfTOhhEhQEw4qOzAAdyY4/ElBtVVzGTNwtwXeM+Hwil8Xq93P0VhQ6FFoD6ZB
 66KOA+EoGc2Lw==
To: =?UTF-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
References: <AKcA0QDJDw7c2rSjY0-LUKqD.3.1628864269869.Hmail.frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <9b000232-c3dc-458c-2507-1dde8a8d985c@kernel.org>
Date: Fri, 13 Aug 2021 22:41:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <AKcA0QDJDw7c2rSjY0-LUKqD.3.1628864269869.Hmail.frank.li@vivo.com>
Content-Language: en-US
X-Headers-End: 1mEYMz-005Fxg-C0
Subject: Re: [f2fs-dev] [PATCH] f2fs: convert
 /sys/fs/f2fs/<disk>/stat/sb_status to use string
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMjAyMS84LzEzIDIyOjE3LCDmnY7miazpn6wgd3JvdGU6Cj4gSEkgQ2hhbywKPiAKPiBGcm9t
OiBDaGFvIFl1IDxjaGFvQGtlcm5lbC5vcmc+Cj4gRGF0ZTogMjAyMS0wOC0xMyAyMjowOTo1Mwo+
IFRvOiAgWWFuZ3RhbyBMaSA8ZnJhbmsubGlAdml2by5jb20+LGphZWdldWtAa2VybmVsLm9yZwo+
IENjOiAgbGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQsbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZwo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGYyZnM6IGNvbnZlcnQgL3N5
cy9mcy9mMmZzLzxkaXNrPi9zdGF0L3NiX3N0YXR1cyB0byB1c2Ugc3RyaW5nPk9uIDIwMjEvOC8x
MyAyMjowMSwgWWFuZ3RhbyBMaSB3cm90ZToKPj4+IERvIG5vdCB1c2UgbnVtYmVycyBidXQgc3Ry
aW5ncyB0byBpbXByb3ZlIHJlYWRhYmlsaXR5IHdoZW4gZmxhZyBpcyBzZXQuCj4+Cj4+IFRoaXMg
YnJlYWtzIG91dHB1dCBydWxlIG9mIHN5c2ZzIGVudHJ5LCBzZWUgYmVsb3cgbGluazoKPj4KPiBX
aGljaCBydWxlPyBvbmUgZW50cnkgc2hvdWxkIHNob3cgb25lIHZhbHVl77yfCgpZZXMsIG9uZSB2
YWx1ZSBwZXIgZmlsZSBwbGVhc2UsIHdoaWNoIGlzIHN1Z2dlc3RlZCBieSBHcmVnLgoKaHR0cHM6
Ly9sa21sLm9yZy9sa21sLzIwMjEvNi8zLzMxOQoKPiAKPiBCdXQgSSBzZWUgdGhhdDoKPiAjIGNh
dCAvc3lzL2ZzL2YyZnMvPGRpc2s+L2ZlYXR1cmVzCj4gZW5jcnlwdGlvbiwgcXVvdGFfaW5vLCB2
ZXJpdHksIHBpbl9maWxlCj4gCj4gU28gdGhlIGZvcm1hdCBvZiBmZWF0dXJlcyBhbHNvIHdyb25n
PwoKICBXaGF0OgkJL3N5cy9mcy9mMmZzLzxkaXNrPi9mZWF0dXJlcwogIERhdGU6CQlKdWx5IDIw
MTcKICBDb250YWN0OgkiSmFlZ2V1ayBLaW0iIDxqYWVnZXVrQGtlcm5lbC5vcmc+CiAgRGVzY3Jp
cHRpb246CTxkZXByZWNhdGVkOiBzaG91bGQgdXNlIC9zeXMvZnMvZjJmcy88ZGlzaz4vZmVhdHVy
ZV9saXN0LwoKVGhhbmtzLAoKPiAKPiBUaHjvvIwKPiAKCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApM
aW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJj
ZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
