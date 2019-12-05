Return-Path: <SRS0=yhtL=Z3=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DD1C43603
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  5 Dec 2019 07:56:27 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0477E24249;
	Thu,  5 Dec 2019 07:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Aa3p4mbl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="mSs8TECa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0477E24249
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iclzu-0003Za-CA; Thu, 05 Dec 2019 07:56:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yangtiezhu@loongson.cn>) id 1iclzp-0003ZL-HG
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 05 Dec 2019 07:56:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:Cc:References:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q4a/HI8RG2MnwVIlNWYid54QfmXAzD+s3g/7U9kXN0I=; b=Aa3p4mblJeh1z2Nfjy3QQxGwnH
 VseyG42Q4zu3EVaIRIbiCWC0TjgK4h7ZYVMVUPdKlXh9C5biOmQUJMVPJ9bn0lmaboK9/cMf1Cofi
 avnUh4RUYt5O8BITrcSj5/eVApslAISokoEGE3a5NnEtcntEErpNFgaK4Z2KOILHU1NM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:Cc:References:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=q4a/HI8RG2MnwVIlNWYid54QfmXAzD+s3g/7U9kXN0I=; b=mSs8TECaDLhOjmiz7o77pWLMbb
 4NeiqqM/yiWei7pdscOjCprv4A4AC+f4gNvVRziqkWQrUVs5boAjD/7PhPjFP11zIEs+AdThJYcxg
 DUrfqf4eXlaAViorpyxUDJbyAYsHNnC2WPdkq9ZYkhdVuC8iq9njQPF3wEub4o7DuTlA=;
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtp (Exim 4.92.2)
 id 1iclzg-00ASkO-SW
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 05 Dec 2019 07:56:21 +0000
Received: from [10.130.0.36] (unknown [123.138.236.242])
 by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxTxQGuOhdmTgHAA--.9S3;
 Thu, 05 Dec 2019 15:55:59 +0800 (CST)
To: Matthew Wilcox <willy@infradead.org>
References: <1575377810-3574-1-git-send-email-yangtiezhu@loongson.cn>
 <20191203135651.GU20752@bombadil.infradead.org>
 <0003a252-b003-0a8c-b4ac-6280557ece06@loongson.cn>
 <20191205070646.GA29612@bombadil.infradead.org>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <b3f23eef-3799-6ddd-43ba-11a90f49279d@loongson.cn>
Date: Thu, 5 Dec 2019 15:55:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20191205070646.GA29612@bombadil.infradead.org>
X-CM-TRANSID: AQAAf9DxTxQGuOhdmTgHAA--.9S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XFyfJr4fAFWDJry7Cr4fGrg_yoW3Wrc_uw
 4kWrZ7Aws8tFZ09Fs8Ga1FqrZxKaya9rykJrn3t3Wjy345X39xCrWDCrn5Wwn3Ga1xJrsI
 qrWavrn8JwnagjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbT8YjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
 8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
 cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
 Mxk0xIA0c2IEe2xFo4CEbIxvr21lc2xSY4AK67AK6r4xMxAIw28IcxkI7VAKI48JMxC20s
 026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
 JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
 v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
 j40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
 4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUc3xhDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Headers-End: 1iclzg-00ASkO-SW
Subject: Re: [f2fs-dev] [PATCH v2] fs: introduce is_dot_dotdot helper for
 cleanup
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
Cc: ecryptfs@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>,
 linux-kernel@vger.kernel.org, Tyler Hicks <tyhicks@canonical.com>,
 Eric Biggers <ebiggers@kernel.org>, linux-fscrypt@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 12/05/2019 03:06 PM, Matthew Wilcox wrote:
> On Thu, Dec 05, 2019 at 08:56:07AM +0800, Tiezhu Yang wrote:
>>> And, as I asked twice in the last round of review, did you benchmark
>>> this change?
>> Before sending this v2 patch, I have done the test used with your test
>> program and already pointed out the following implementation is better:
> I didn't mean "have you run the test program i wrote".  I meant "have you
> booted a kernel with this change and done some performance measurements
> to see if you've changed anything".

Oh, no, it is hard to measure the performance influence with this patch.
Based on the above analysis, I think the performance influence is very
small due to is_dot_dotdot() is a such short static inline function.

Thanks,

Tiezhu Yang



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
