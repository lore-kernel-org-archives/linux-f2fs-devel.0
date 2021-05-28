Return-Path: <SRS0=jEyb=KX=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE7CC4707F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 May 2021 02:50:41 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8F20613C9
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 May 2021 02:50:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8F20613C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lmSa7-00030M-0D; Fri, 28 May 2021 02:50:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1lmSZm-0002yG-Rb
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 28 May 2021 02:50:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:CC:References:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y8qG+zwEHYzlCxbTIAZ+MM/k6CmwdIub30oYmhOgtEg=; b=azWy1iKwTlgXf4G7KEoqps1vZZ
 txC4dqL4qdqfVDgsSDufboOkfCybQsDoVCGZncKmoKlTJfjkbVBQoK/nFnvK1xXnZisQAVLl/C6bI
 sn0jPr5I135A94uFv3WuIisnnp0EqPHz9zvl6+DW2BvX5iRz0r/gI6rrzoNqvbV7jur4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:CC:References:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=y8qG+zwEHYzlCxbTIAZ+MM/k6CmwdIub30oYmhOgtEg=; b=BhetiVTrnksb+yqHMNh6URCb1J
 PUiPUp/v8hbtuxX6q7XfAze2grKcg/3gwQRHSnR40HM/JAVTgQxqGjRqaLkEkyfA7TSFPtUCx6CZl
 p+p432q8szHj58aJhY5ntsT1xxWt0GGlJhAWuGaLHSBnkytfr674NeMKhQ8aPMhnLtC4=;
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lmSZY-0004da-52
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 28 May 2021 02:50:19 +0000
Received: from dggemx753-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Frpxb67VdzYn5N;
 Fri, 28 May 2021 10:47:15 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by
 dggemx753-chm.china.huawei.com (10.0.44.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 28 May 2021 10:49:55 +0800
To: <changfengnan@vivo.com>, <jaegeuk@kernel.org>
References: <20210518125113.1712-1-changfengnan@vivo.com>
 <7ad8bae8-6e38-5ff7-add8-fe1023569f43@huawei.com>
 <000001d7515e$458f3db0$d0adb910$@vivo.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <ffdbecea-51ce-69db-6b4d-8ea7eb9c43fc@huawei.com>
Date: Fri, 28 May 2021 10:49:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <000001d7515e$458f3db0$d0adb910$@vivo.com>
Content-Language: en-US
X-Originating-IP: [10.136.110.154]
X-ClientProxiedBy: dggemx703-chm.china.huawei.com (10.1.199.50) To
 dggemx753-chm.china.huawei.com (10.0.44.37)
X-CFilter-Loop: Reflected
X-Headers-End: 1lmSZY-0004da-52
Subject: Re: [f2fs-dev] =?utf-8?b?562U5aSNOiAgW1JGQyBQQVRDSF0gZjJmczogY29t?=
 =?utf-8?q?press=3A_remove_unneeded_read_when_rewrite_whole_cluster?=
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gMjAyMS81LzI1IDIwOjA1LCBjaGFuZ2ZlbmduYW5Adml2by5jb20gd3JvdGU6Cj4geWVzLCBJ
IGp1c3QgY2hlY2sgd2hlYXRoZXIgdGhlIHdob2xlIHBhZ2Ugd2FzIGRpcnR5LCBiZWNhdXNlIG9m
IHdoZW4gd3JpdGUKPiBjYWNoZSBmMmZzX3ByZXBhcmVfY29tcHJlc3Nfb3ZlcndyaXRlIHdpbGwg
YmUgY2FsbGVkIGFnYWluLAo+IHdoZW4gdXBkYXRlIHdob2xlIGNsdXN0ZXIsICBjYyBpbiBwcmVw
YXJlX2NvbXByZXNzX292ZXJ3cml0ZSB3aWxsIGJlIGVtcHR5LAo+IHNvIHdpbGwgbm90IHN1Ym1p
dCBiaW8uCj4gd2hlbiBvbmx5IHVwZGF0ZSBvbmUgcGFnZSBpbiBjbHVzdGVyLCAgY2MgaW4gcHJl
cGFyZV9jb21wcmVzc19vdmVyd3JpdGUgd2lsbAo+IG5vdCBiZSBlbXB0eSwgc28gd2lsbCBzdWJt
aXQgYmlvLgo+IFRoaXMgaXMgbXkgdGhpbmtpbmcsIG5vdCBzdXJlIGlmIEkndmUgbWlzc2VkIGFu
eXRoaW5nCgpXZWxsLCBpdCBsb29rcyBtb3JlIGxpa2Ugd2UgZGlkIGZvciBtbWFwKCkgd3JpdGUg
Y2FzZS4KClNvIEkgZ3Vlc3Mgd2UgY2FuIGNoYW5nZSBhcyBiZWxvdzoKClRvIEphZWdldWssIGNv
bW1lbnRzPwoKLS0tCiAgZnMvZjJmcy9kYXRhLmMgfCAyICstCiAgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZnMvZjJmcy9kYXRhLmMg
Yi9mcy9mMmZzL2RhdGEuYwppbmRleCAyZWE4ODdhMTE0YzguLjcyM2M1OWRmNTFiNyAxMDA2NDQK
LS0tIGEvZnMvZjJmcy9kYXRhLmMKKysrIGIvZnMvZjJmcy9kYXRhLmMKQEAgLTMzMjMsNyArMzMy
Myw3IEBAIHN0YXRpYyBpbnQgZjJmc193cml0ZV9iZWdpbihzdHJ1Y3QgZmlsZSAqZmlsZSwgc3Ry
dWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcsCiAgCX0KCiAgI2lmZGVmIENPTkZJR19GMkZTX0ZT
X0NPTVBSRVNTSU9OCi0JaWYgKGYyZnNfY29tcHJlc3NlZF9maWxlKGlub2RlKSkgeworCWlmIChm
MmZzX2NvbXByZXNzZWRfZmlsZShpbm9kZSkgJiYgbGVuICE9IFBBR0VfU0laRSkgewogIAkJaW50
IHJldDsKCiAgCQkqZnNkYXRhID0gTlVMTDsKLS0gCjIuMjkuMgoKVGhhbmtzLAoKPiAKPiAKPiAt
LS0tLdPKvP7Urbz+LS0tLS0KPiC3orz+yMs6IENoYW8gWXUgPHl1Y2hhbzBAaHVhd2VpLmNvbT4K
PiC3osvNyrG85DogMjAyMcTqNdTCMjTI1SAxOTozOQo+IMrVvP7IyzogRmVuZ25hbiBDaGFuZyA8
Y2hhbmdmZW5nbmFuQHZpdm8uY29tPjsgamFlZ2V1a0BrZXJuZWwub3JnOwo+IGNoYW9Aa2VybmVs
Lm9yZzsgbGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKPiDW98ziOiBSZTog
W2YyZnMtZGV2XSBbUkZDIFBBVENIXSBmMmZzOiBjb21wcmVzczogcmVtb3ZlIHVubmVlZGVkIHJl
YWQgd2hlbgo+IHJld3JpdGUgd2hvbGUgY2x1c3Rlcgo+IAo+IE9uIDIwMjEvNS8xOCAyMDo1MSwg
RmVuZ25hbiBDaGFuZyB3cm90ZToKPj4gRm9yIG5vdyx3aGVuIG92ZXJ3cml0ZSBjb21wcmVzc2Vk
IGZpbGUsIHdlIG5lZWQgcmVhZCBvbGQgZGF0YSB0byBwYWdlCj4+IGNhY2hlIGZpcnN0IGFuZCB1
cGRhdGUgcGFnZXMuCj4+IEJ1dCB3aGVuIHdlIG5lZWQgb3ZlcndyaXRlIHdob2xlIGNsdXN0ZXIs
IHdlIGRvbid0IG5lZWQgb2xkIGRhdGEKPj4gYW55bW9yZS4KPiAKPiBJIG9ubHkgc2VlIHlvdSBq
dXN0IGNoZWNrIHRoZSB3aG9sZSBwYWdlIHdhcyBkaXJ0eSBhcyBiZWxvdyByYXRoZXIgdGhhbiB0
aGUKPiB3aG9sZSBjbHVzdGVyIGlzIGRpcnR5IGR1cmluZyB3cml0ZSgpLgo+IAo+IFRoYW5rcywK
PiAKPj4gKwlpZiAobGVuID09IFBBR0VfU0laRSkKPj4gKwkJcmV0dXJuIDA7Cj4+ICAgIAkvKiBj
b21wcmVzc2VkIGNhc2UgKi8KPj4gICAgCXByZWFsbG9jID0gKHJldCA8IGNjLT5jbHVzdGVyX3Np
emUpOwo+PiAgICAKPiAKPiAKPiAuCj4gCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJm
cy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5u
ZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
