Return-Path: <SRS0=Y/5H=EF=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_ADSP_ALL,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5F1C55179
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 30 Oct 2020 09:22:30 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55223206ED;
	Fri, 30 Oct 2020 09:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="gFCDgp9a";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="CuofF6aY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=autistici.org header.i=@autistici.org header.b="F/tw3hSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55223206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=autistici.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kYQc6-0005SP-6b; Fri, 30 Oct 2020 09:22:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <kitestramuort@autistici.org>) id 1kYQc5-0005Rp-AS
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 30 Oct 2020 09:22:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Content-Type
 :References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kLHqoNTSl1SwhzwSnCr51fbmYNvmWfCZxrpFVfxC1Bg=; b=gFCDgp9am21Azv752GJHtA96PS
 sUTyX109uL72l9uaLKXcOl0P63zXHIeLHTpsEsxESprMirsZvE0DsWJwogcxnj2DgXeK4Rqt1lKpj
 DGqP1qx2XYTeVVdl5rweJHgC46GYgNanXwhdWmIoVoN1ZF3jAMigrvYbOLbn6nktXuGY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
 In-Reply-To:Date:To:From:Subject:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kLHqoNTSl1SwhzwSnCr51fbmYNvmWfCZxrpFVfxC1Bg=; b=CuofF6aYksWSPqSaL0jlHeJ4be
 DLuw/SvwlDXQU8gIB60WxYqmeLpmebyZhIUPAma/joksd/JnCtOCSGpzBtn99ijP+9r01r1JTVYZV
 rMHghCxj0qAw/HByxfaRLDQ+VqwPOwvh2JNsmW5BqjcUUcU3KlL1zwdQcuY8apNlccBc=;
Received: from confino.investici.org ([212.103.72.250])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kYQbn-002IpW-I1
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 30 Oct 2020 09:22:25 +0000
Received: from mx1.investici.org (unknown [127.0.0.1])
 by confino.investici.org (Postfix) with ESMTP id 4CMx4B3lF1z12Zp;
 Fri, 30 Oct 2020 08:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autistici.org;
 s=stigmate; t=1604048170;
 bh=kLHqoNTSl1SwhzwSnCr51fbmYNvmWfCZxrpFVfxC1Bg=;
 h=Subject:From:To:Date:In-Reply-To:References:From;
 b=F/tw3hSOC6gPexaCeYtyeEuQKDWWaA8nf3DfgHTWGY7lA+L64vi6eGcILKnW8BKRU
 F+y02a/MHPL0/ltnRyvlF6A085JACDUiEreIpsOSRvwNVIn8VVTQhGdctxPhCnA8XS
 25+ueKpKt56X3Z8G6bi4ElZr5tb+WCPyfPs9XYIQ=
Received: from [212.103.72.250] (mx1.investici.org [212.103.72.250])
 (Authenticated sender: kitestramuort@autistici.org) by localhost (Postfix)
 with ESMTPSA id 4CMx486KNJz12ZC; 
 Fri, 30 Oct 2020 08:56:08 +0000 (UTC)
Message-ID: <2a029c2ad9ae558adb5147be767329e542b20b50.camel@autistici.org>
From: kitestramuort <kitestramuort@autistici.org>
To: Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 30 Oct 2020 09:56:06 +0100
In-Reply-To: <1c0ea7b6-73b5-9027-e67f-3dfff8e50855@huawei.com>
References: <4c3d4693b7e60d6e87b6255986c9b21f42f58cf8.camel@autistici.org>
 <1c0ea7b6-73b5-9027-e67f-3dfff8e50855@huawei.com>
User-Agent: Evolution 3.38.1 
MIME-Version: 1.0
X-Headers-End: 1kYQbn-002IpW-I1
Subject: Re: [f2fs-dev] Linux 5.10-rc1: F2FS-fs access invalid blkaddr
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

T24gRnJpLCAyMDIwLTEwLTMwIGF0IDA5OjUwICswODAwLCBDaGFvIFl1IHdyb3RlOgo+IE9uIDIw
MjAvMTAvMzAgMDo0MCwga2l0ZXN0cmFtdW9ydCB3cm90ZToKPiA+IEhlbGxvLAo+ID4gdGhlIG5l
dyByYyBpcyBnZW5lcmF0aW5nwqB0aGUgZXJyb3IgYmVsb3cgbXVsdGlwbGUgdGltZXMgYSBmZXcK
PiA+IG1pbnV0ZXMKPiA+IGFmdGVyIGJvb3QuCj4gPiAKPiAKPiBDb3VsZCB5b3UgcGxlYXNlIHRy
eSBmc2NrIC0tZHJ5LXJ1biwgYW5kIHNoYXJlIHRoZSBvdXRwdXQ/CgpJbmZvOiBEcnkgcnVuCklu
Zm86IFNlZ21lbnRzIHBlciBzZWN0aW9uID0gMQpJbmZvOiBTZWN0aW9ucyBwZXIgem9uZSA9IDEK
SW5mbzogc2VjdG9yIHNpemUgPSA1MTIKSW5mbzogdG90YWwgc2VjdG9ycyA9IDE2OTI0Mjc2NjMg
KDgyNjM4MCBNQikKSW5mbzogTUtGUyB2ZXJzaW9uCiAgIkxpbnV4IHZlcnNpb24gNC4yMC4wLWFy
Y2gxLTEtQVJDSCAoYnVpbGR1c2VyQGhlZnRpZy0yOTg1OSkgKGdjYwp2ZXJzaW9uIDguMi4xIDIw
MTgxMTI3IChHQ0MpKSAjMSBTTVAgUFJFRU1QVCBNb24gRGVjIDI0IDAzOjAwOjQwIFVUQwoyMDE4
IgpJbmZvOiBGU0NLIHZlcnNpb24KICBmcm9tICJMaW51eCB2ZXJzaW9uIDUuMi41LWFyY2gxLTEt
QVJDSCAoYnVpbGR1c2VyQGhlZnRpZy0xMTg5MDgpIChnY2MKdmVyc2lvbiA5LjEuMCAoR0NDKSkg
IzEgU01QIFBSRUVNUFQgV2VkIEp1bCAzMSAwODozMDozNCBVVEMgMjAxOSIKICAgIHRvICJMaW51
eCB2ZXJzaW9uIDUuMTAuMC1yYzEtUyAocm9vdEB4MjEwKSAoZ2NjIChHQ0MpIDEwLjIuMCwgR05V
CmxkIChHTlUgQmludXRpbHMpIDIuMzUuMSkgIzggU01QIFBSRUVNUFQgV2VkIE9jdCAyOCAxODo1
ODoyOCBDRVQgMjAyMCIKSW5mbzogc3VwZXJibG9jayBmZWF0dXJlcyA9IDAgOiAKSW5mbzogc3Vw
ZXJibG9jayBlbmNyeXB0IGxldmVsID0gMCwgc2FsdCA9CjAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwCkluZm86IHRvdGFsIEZTIHNlY3RvcnMgPSAxNjkyNDI3NjU2ICg4MjYzODAgTUIp
CkluZm86IENLUFQgdmVyc2lvbiA9IDI4NDc3NTUKSW5mbzogY2hlY2twb2ludCBzdGF0ZSA9IDU1
IDogIGNyYyBmc2NrIGNvbXBhY3RlZF9zdW1tYXJ5IHVubW91bnQKCltGU0NLXSBVbnJlYWNoYWJs
ZSBuYXQgZW50cmllcyAgICAgICAgICAgICAgICAgICAgICAgIFtPay4uXSBbMHgwXQpbRlNDS10g
U0lUIHZhbGlkIGJsb2NrIGJpdG1hcCBjaGVja2luZyAgICAgICAgICAgICAgICBbT2suLl0KW0ZT
Q0tdIEhhcmQgbGluayBjaGVja2luZyBmb3IgcmVndWxhciBmaWxlICAgICAgICAgICAgW09rLi5d
IFsweDUwY10KW0ZTQ0tdIHZhbGlkX2Jsb2NrX2NvdW50IG1hdGNoaW5nIHdpdGggQ1AgICAgICAg
ICAgICAgW09rLi5dClsweDk1ODk4MTldCltGU0NLXSB2YWxpZF9ub2RlX2NvdW50IG1hdGNoaW5n
IHdpdGggQ1AgKGRlIGxvb2t1cCkgIFtPay4uXSBbMHgyYmVjOTddCltGU0NLXSB2YWxpZF9ub2Rl
X2NvdW50IG1hdGNoaW5nIHdpdGggQ1AgKG5hdCBsb29rdXApIFtPay4uXSBbMHgyYmVjOTddCltG
U0NLXSB2YWxpZF9pbm9kZV9jb3VudCBtYXRjaGVkIHdpdGggQ1AgICAgICAgICAgICAgIFtPay4u
XSBbMHgyOWY5ODVdCltGU0NLXSBmcmVlIHNlZ21lbnRfY291bnQgbWF0Y2hlZCB3aXRoIENQICAg
ICAgICAgICAgIFtPay4uXSBbMHgxODEwNV0KW0ZTQ0tdIG5leHQgYmxvY2sgb2Zmc2V0IGlzIGZy
ZWUgICAgICAgICAgICAgICAgICAgICAgW09rLi5dCltGU0NLXSBmaXhpbmcgU0lUIHR5cGVzCltG
U0NLXSBvdGhlciBjb3JydXB0ZWQgYnVncyAgICAgICAgICAgICAgICAgICAgICAgICAgIFtPay4u
XQoKRG9uZTogMjYzLjI1MDg1MCBzZWNzCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYy
ZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2Uu
bmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
