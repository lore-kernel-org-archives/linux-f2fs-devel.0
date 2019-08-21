Return-Path: <SRS0=qRZ7=WR=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69170C3A59E
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 21 Aug 2019 13:15:26 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3441F214DA;
	Wed, 21 Aug 2019 13:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="G22sEsMb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="UHILctCK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3segr/6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3441F214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1i0QST-0006Bj-Ii; Wed, 21 Aug 2019 13:15:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1i0QSR-0006BW-Bx
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 21 Aug 2019 13:15:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nKBgpZcmqM2KWTjk4grQiWnYqdvVACHVN2Y2Q+X891A=; b=G22sEsMbAQUWnaFbuKEBY8nZ0e
 K77BiFNijKJStGVV4bXSbZCOcW14zeSRBcOh5CYkmfyU4UmxVSI0BbHauxqXvBaXz8zRyf3w+eiJ3
 5wTI8xHZP2DS9TEpv9Lyg5fJ9321d3oT7ou/0jx2b4nn+WZOJlSfyXY0IzgToIkopQYU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nKBgpZcmqM2KWTjk4grQiWnYqdvVACHVN2Y2Q+X891A=; b=UHILctCKmmOZbjIJFTssKrJAPE
 vTPCwDuSFMocplJAq/fAiVDA1YcYrNMacUnamRr8UVHe7HfAvrEqhDm75O+46FygT0f30K47zWTWj
 zee8b2QHJmhjkz5fX5KRAS0St/BGev/GGvW/U14S8g+fagdukG9i3+eztGVAV3mjFZQU=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1i0QSQ-00B2jB-9D
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 21 Aug 2019 13:15:23 +0000
Received: from [192.168.0.101] (unknown [180.111.132.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9CC2B214DA;
 Wed, 21 Aug 2019 13:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1566393316;
 bh=EO9Bip6DSF9x/AWrsU50iQqY5CV6rf7s8XCVw7bhH/k=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=C3segr/6YdtzYrAkfoIuaHjBH3hsXn3HQvP3H7GYJ/LLFZRYBIIIVVUZtmNmVhUes
 SQL67+adFwRxD/HgPcOsaqyJ0V1E7R04rt0k0RuHtHUbHfGfjeaOLhvl9EEyLTddQa
 PwteJ65+4VijcgcfVc0cubkDO43wTJ1A/F01XGUU=
To: Daniel Rosenberg <drosen@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <yuchao0@huawei.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-f2fs-devel@lists.sourceforge.net
References: <20190723230529.251659-1-drosen@google.com>
 <20190723230529.251659-4-drosen@google.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <354102fb-e076-78d4-174d-5a193cae70f0@kernel.org>
Date: Wed, 21 Aug 2019 21:15:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190723230529.251659-4-drosen@google.com>
Content-Language: en-US
X-Headers-End: 1i0QSQ-00B2jB-9D
Subject: Re: [f2fs-dev] [PATCH v4 3/3] f2fs: Support case-insensitive file
 name lookups
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
Cc: linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2019-7-24 7:05, Daniel Rosenberg via Linux-f2fs-devel wrote:
> +static int f2fs_d_compare(const struct dentry *dentry, unsigned int len,
> + const char *str, const struct qstr *name)
> +{
> +	struct qstr qstr = {.name = str, .len = len };
> +
> +	if (!IS_CASEFOLDED(dentry->d_parent->d_inode)) {
> +		if (len != name->len)
> +			return -1;
> +		return memcmp(str, name, len);

66883da1eee8 ("ext4: fix dcache lookup of !casefolded directories")

memcmp(str, name->name, len);


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
