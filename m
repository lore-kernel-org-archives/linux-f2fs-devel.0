Return-Path: <SRS0=Y/5H=EF=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35424C4363A
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 30 Oct 2020 03:25:45 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75CC2206F7;
	Fri, 30 Oct 2020 03:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="cjuOTbla";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="hl2xh8v+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqcmPBdy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75CC2206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kYL2t-0001BE-I8; Fri, 30 Oct 2020 03:25:43 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <daeho43@gmail.com>) id 1kYL2s-0001B0-B4
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 30 Oct 2020 03:25:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q9dGjCASe4qWBi3GAUQrS92wx12xsyqvkjY3ZpGJK04=; b=cjuOTblaPe/AuKHK834WI797/E
 oDSL3N2BP9nDapkYz2SuQ4N9KF1o2MeWiUseOTTzlX7qvLE+Oe1coQCaYZf+tiKjpnazeOLzzpmN8
 p4Spf9DwLRpNeGQG6DifvU7GU3YGlcS6C0zLvlul8OD8xf7eLnvJFDIvWxkTvAm5eNQY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Q9dGjCASe4qWBi3GAUQrS92wx12xsyqvkjY3ZpGJK04=; b=hl2xh8v+WoZZ6ZnzSRzf6EN92e
 Y5KWyBSS5hRYWa5/xizsiG/r4jUq/pZ/gp2KhGRVZkWMGnHnc3TRnj+En0l72ZSvy9a2bD2+zHlPF
 siEkATFO7vhXYbpRLuXj2+s0VWID8rYNKtinoQ3L4Ha+qDMLMTuAjqfiAFC+cBUcmCfI=;
Received: from mail-lj1-f175.google.com ([209.85.208.175])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1kYL2h-001xpp-8J
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 30 Oct 2020 03:25:42 +0000
Received: by mail-lj1-f175.google.com with SMTP id 2so5358822ljj.13
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 29 Oct 2020 20:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Q9dGjCASe4qWBi3GAUQrS92wx12xsyqvkjY3ZpGJK04=;
 b=LqcmPBdyGJPXEn6+gMCKB9Mm6nOIUnqvu1r6Ble/fx6SuFlrdS/EvR/MDIp+kpVmpy
 EmmfWbHoo1PHgDDRd6kk5+6ZQWEx8LnXPNe2lAtP/B1NQcGYQ0Q+fuZM4B2baG66cnBx
 Ia3Lvleo3DlvoZrUcrQW3vXDLYu7jqxtr4GoGEzhXWy0K/3Odda7NJF2YkYTYKLRl/Xx
 2B6C/w6k2BfeQmTumJ3njxUCjYyL8OlCUKNvFNZcEg4fWWvmDYIDStkIrtAjZwP/2F++
 aMxMpDaiP8FKgYV2f/lcSHi453Wj+rgAYlfMfgUygrOU6AAFd4f6Tf261oB/aUQE3MFY
 PJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Q9dGjCASe4qWBi3GAUQrS92wx12xsyqvkjY3ZpGJK04=;
 b=BjVXqkMdvCPEt6NsaL836Gv5bdEs4pweoqxDY3FJZvXehxRISvO0DfEDyL3vD1QuAr
 JbupcxfUElQQ3srWvvIB8+SUaCq1geH6yOY3jMfEO7kp68YQTMaUvGyFZr99I67UaDQB
 gRwykSB6IddHr0hMnsAxz3lQCiJ6OdEhP/HdjE8QIMLmTM6TF87oNSIOWRojJov0Lhsb
 +3LnwEagB+O+/z7jCmx6CIvAuPH36RJ5aItqWIXk+8a0vJUww42sB1Nk8aiZvUxdSgd1
 KeIXRXXP59Mvb5jR+Ht9WN43gprhYyWdAS7jMJKF+3d1gHtkVv3zj4lr7ZMbYggoMkhw
 wUfw==
X-Gm-Message-State: AOAM5335ZhPz8rMXfZ+5yeJRljKBVGVq4hLW6+lFfXgwKtqVRH4xuziy
 qCOvl91wTiRHyyFCovcMrCmzL2dOFVbuM3OEKwE=
X-Google-Smtp-Source: ABdhPJxBokkVQP1gYf3zsHpnOJXP0FEn9vAd8MKCJGJKF6imUQBIy1+pl8ND3Qg+PWOD8rt39ahifROZYzMBOO6GJwE=
X-Received: by 2002:a2e:700a:: with SMTP id l10mr144269ljc.265.1604028317337; 
 Thu, 29 Oct 2020 20:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201029041538.4165209-1-daeho43@gmail.com>
 <861e569d-feae-c521-35b7-dcb8b79cdfba@huawei.com>
 <61d43f5d-f26c-525a-6405-bae0ca495c6d@huawei.com>
In-Reply-To: <61d43f5d-f26c-525a-6405-bae0ca495c6d@huawei.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 30 Oct 2020 12:25:06 +0900
Message-ID: <CACOAw_xHM-FB3pRfFnjF-9eVgo=cxPh=tsLyEX30NHaz2gAbtQ@mail.gmail.com>
To: Chao Yu <yuchao0@huawei.com>
X-Headers-End: 1kYL2h-001xpp-8J
Subject: Re: [f2fs-dev] [PATCH v5 1/2] f2fs: add
 F2FS_IOC_GET_COMPRESS_OPTION ioctl
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T3BwcywgSSBtaXNzZWQgdGhpcy4KV2UgbmVlZCB2Ny4uLiBsb2wKCjIwMjDrhYQgMTDsm5QgMzDs
nbwgKOq4iCkg7Jik7KCEIDExOjM3LCBDaGFvIFl1IDx5dWNoYW8wQGh1YXdlaS5jb20+64uY7J20
IOyekeyEsToKPgo+IE9uIDIwMjAvMTAvMjkgMTU6MjQsIENoYW8gWXUgd3JvdGU6Cj4gPiBPbiAy
MDIwLzEwLzI5IDEyOjE1LCBEYWVobyBKZW9uZyB3cm90ZToKPgo+ID4+ICsgICAgaW5vZGVfbG9j
ayhpbm9kZSk7Cj4gPgo+ID4gSXQncyBtaW5vciwKPiA+Cj4gPiBpbm9kZV9sb2NrX3NoYXJlZCgp
Pwo+ID4KPiA+PiArCj4gPj4gKyAgICBpZiAoIWYyZnNfY29tcHJlc3NlZF9maWxlKGlub2RlKSkg
ewo+ID4+ICsgICAgICAgICAgICBpbm9kZV91bmxvY2soaW5vZGUpOwo+ID4KPiA+IGlub2RlX3Vu
bG9ja19zaGFyZWQoKT8KPiA+Cj4gPj4gKyAgICAgICAgICAgIHJldHVybiAtRU5PREFUQTsKPiA+
PiArICAgIH0KPiA+PiArCj4gPj4gKyAgICBvcHRpb24uYWxnb3JpdGhtID0gRjJGU19JKGlub2Rl
KS0+aV9jb21wcmVzc19hbGdvcml0aG07Cj4gPj4gKyAgICBvcHRpb24ubG9nX2NsdXN0ZXJfc2l6
ZSA9IEYyRlNfSShpbm9kZSktPmlfbG9nX2NsdXN0ZXJfc2l6ZTsKPiA+PiArCj4gPj4gKyAgICBp
bm9kZV91bmxvY2soaW5vZGUpOwo+ID4KPiA+IGRpdHRvLgo+Cj4gQW55IGNvbW1lbnRzPwo+Cj4g
VGhhbmtzLAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291
cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZv
L2xpbnV4LWYyZnMtZGV2ZWwK
