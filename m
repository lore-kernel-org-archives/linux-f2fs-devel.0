Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E67DC43458
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  6 Jul 2026 07:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y71nJFjmYMenFm7qmpIc+Xd0GGaXIeihPG/+sGfK4go=; b=VMP9CcdLdZYOvWh69jV1K8OWvT
	hLIF6v8ha21pDQ3IHi95+FhPTNiMUARqYjK1nY8vCBIIBAbwewghkc7AXDDWVmVOhNMn7aaNinVS9
	iRow3DIbi+0cvkrlGgdEySFOxX2u02mLRO597Etgrl2bTFIAGmct9uukANm+ZLqPowsA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wge0I-000166-Ku;
	Mon, 06 Jul 2026 07:44:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1wge02-00014T-Et
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 07:44:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K2sLqbySZjHysKxA6BZoysTxfs61Z1Uon0anobcMBkM=; b=U5IAzLuNzXxASspFIM+8fx7qJ4
 yEJYV8h2d5T62rIgFG1wfY80TELjyCdMlKEpL+geqfUz2EYumP+iW7Vt7FTbPXJvAnWy6lawmCHb+
 qwuG+DuxVeUbLFcF0f3L9bzvwPYO+gsviypOyAl0mdDwRjHQ+z9tt8blbnfaMQaOhf7Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=K2sLqbySZjHysKxA6BZoysTxfs61Z1Uon0anobcMBkM=; b=aB3NichNM0uspn4kyYyY32NUQ7
 FS8IufADEnO/Hlshs26AHn8JUnqWE+5nDuak2ws+bMYY7yqGFlBrJjtuT3ofOAVtyqu6mVILJqBVd
 j1EJ8/bk1DWTKDy0aTOaQPP9C1G5c2qDhsdbm8+XSLKnNMxySJpJL6IxPqX9agj9Er9E=;
Received: from m16.mail.126.com ([220.197.31.9])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wge00-0005t3-PE for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 07:44:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
 Content-Type; bh=K2sLqbySZjHysKxA6BZoysTxfs61Z1Uon0anobcMBkM=;
 b=IK6AjMEbbjlWa1u36v2fyYrzvf+nvwAt+NsvsjnstxowtYFHUZ6wcsiviBNEc+
 hQHvpzdc/MR0thRtYw0n08vG1qYlLlQl7Y2bjDVkZNq2ERwTqbgigNP5pWU7DSdK
 +Nw00M0VFf0NWJm5j29JHsxq4U7HLKfeemtsDRJLsVwsI=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id
 _____wD3H7ClXEtqIfm7Cg--.59316S2; 
 Mon, 06 Jul 2026 15:43:34 +0800 (CST)
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon,  6 Jul 2026 15:43:33 +0800
Message-ID: <20260706074333.2805230-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <a9b257fd-68ce-45a6-b4df-be5faf583e2d@kernel.org>
References: <a9b257fd-68ce-45a6-b4df-be5faf583e2d@kernel.org>
 <20260622160830.324455-2-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wD3H7ClXEtqIfm7Cg--.59316S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrCrWDCryDXw4xZw1kWFy8Krg_yoWxWrX_Wr
 ykCaykG3y8JrsxJF17G3Zrt34jvan3XFy8uayxXF1IyrykG3y8Cw4jgwn09FWvqF45trZ0
 9r4DXw4rZryfWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRJKs7UUUUU==
X-Originating-IP: [114.247.175.250]
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBowatfWpLXKYZzgAA35
X-Headers-End: 1wge00-0005t3-PE
Subject: Re: [f2fs-dev] [RFC PATCH v2 01/10] f2fs: extend folio state for
 large folio write path
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
From: Nanzhe Zhao via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Cc: baohua@kernel.org, zhaonanzhe@xiaomi.com, Ryan.Roberts@arm.com,
 jyescas@google.com, Dev.Jain@arm.com, David.Hildenbrand@arm.com,
 linux-kernel@vger.kernel.org, zhangbo56@xiaomi.com, kaleshsingh@google.com,
 jaegeuk@kernel.org, lipengfei28@xiaomi.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

Yes, this can happen. By design, prepare_large_folio_write_begin() skips
f2fs_folio_state allocation when the write fully covers the entire large
folio (i.e., the folio is already uptodate or len == folio_size(folio)).
This is an optimization for normal buffered writes; I somehow didn't apply 
the same optimization to atomic buffered writes since they are relatively
rare.

In that case, f2fs_update_dirty_folio() may call folio_set_f2fs_reference()
on a large folio that does not yet have an ffs, so the flag is stored
directly in folio->private. 

But I agree this is a bit subtle and worth discussing.  

Thanks,
Nanzhe



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
