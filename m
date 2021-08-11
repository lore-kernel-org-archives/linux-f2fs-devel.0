Return-Path: <SRS0=Klf2=NC=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E98EC4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Aug 2021 02:49:08 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDF756056B;
	Wed, 11 Aug 2021 02:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BDF756056B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vivo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mDeIl-0001zA-07; Wed, 11 Aug 2021 02:49:07 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bo.wu@vivo.com>) id 1mDeIj-0001yv-8E
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Aug 2021 02:49:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Date:Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+8LJayoFX5q/5di+DCsqTX4n8BkdXihpHqAunyGkpsg=; b=XCHotlVIQW1BB3E2xP+ijkSTP6
 M9yRremFK/AwENVBsC/e2/E9qGRBVxZDcs2DM4Rt+Zd4icSDVPwGDbZNb+EBFifM19j8GYkDYP9Fr
 j3a+NN/NncEHXtrDU0hhtcKWPr5Ht2aKHpLZEXnbl869EKEVV0DG0p+go0UGteJcQqFc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Message-ID:To:
 Subject:From:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+8LJayoFX5q/5di+DCsqTX4n8BkdXihpHqAunyGkpsg=; b=B
 97FKUJPI+QjCpBbrnRi+rAEP/aUZdGv9P7/8E1G31uGnC7RaxVGPPTTIoGTbH/P9OF6rC3OSlABnx
 BZIHySbiX4UGsBlIrkVLuB6C9bXRQVEqwQAN1ZlGbovI1n8CVNzE30MIOs0xu01eVn8wa6vb2B/js
 FzfcuIbBo9EPITOQ=;
Received: from mail-m17656.qiye.163.com ([59.111.176.56])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mDeIf-0000zt-Oq
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Aug 2021 02:49:05 +0000
Received: from [172.25.45.51] (unknown [58.251.74.232])
 by mail-m17656.qiye.163.com (Hmail) with ESMTPA id 7AAC3C402E6;
 Wed, 11 Aug 2021 10:48:53 +0800 (CST)
From: Wu Bo <bo.wu@vivo.com>
To: bo.wu@vivo.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Message-ID: <5b68208b-fd94-bf4e-fc4b-d79d13abf1c6@vivo.com>
Date: Wed, 11 Aug 2021 10:48:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
 kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUJKQkxWQ0hLHklCTUJIGh
 1DVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MAg6HTo6OT9IAyw3HUpPQxxM
 ERhPC0JVSlVKTUlDTU5LSkhPTklOVTMWGhIXVRkUVQwOOw0SDRRVGBQWRVlXWRILWUFZTkNVSU5K
 VUxPVUlISVlXWQgBWUFKSEtCNwY+
X-HM-Tid: 0a7b331cd85eda02kuws7aac3c402e6
X-Headers-End: 1mDeIf-0000zt-Oq
Subject: [f2fs-dev] f2fs do DIO write make file corruption
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

I use the following command to create a file, the file may got corruption:
	f2fs_io write 2 0 512 inc_num dio $path

And when I use bio or to set the chunk size to 1 block, the file is 
normal. The commands as following:
	f2fs_io write 2 0 512 inc_num buffered $path
	f2fs_io write 1 0 512 inc_num dio $path

I find this bug on old kernel version 4.14.117, and not find on version 
4.19.152. So this bug is fixed. Can anyone can tell me which patch fixed 
this bug?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
