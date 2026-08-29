Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D20AEC61DD6
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 29 Aug 2026 06:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BirvrBv2lXXsQkt7Hn6kuVC+YxuxU5VluVzQVCCL0g4=; b=TkD+8ybtDxW8d0NI5uX/09o3xc
	jCZ4HVb5EMaJl9IrVXc7TvXFLH7EknKRmiFThmUmdoDz3i2KeBGI6cxYr0FnKOSTmazk/qGOJyLcb
	Hz7+/O6CJ870Rc8jQMvL1vO9NuAe6+E09HWO88VfEgA4JuF7Lnzgy++Z0czNWRybBLBs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x0CE9-00065g-8Z;
	Sat, 29 Aug 2026 06:07:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1x0CE7-00065Z-U7
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 29 Aug 2026 06:07:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GPuxmifIgDDwJZd/SBO1euENzZKqws9a+V2RPHqyjdQ=; b=hJOuMkWCpjchda5vRQIHw4n7MG
 0dycF6Ca7Ri2nTtPOC+mt4ABgiyxcszm/LmOvZ3ToehzmyXWBbj+ySsF0F0AFMG+cyhq2pRFC0H1Q
 UWmmfndYqmbCMX+p8J3Ea1npSHfGijTKMmq9IzdzHba1o93l4LSKCV2y7sWqntkkWPvM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GPuxmifIgDDwJZd/SBO1euENzZKqws9a+V2RPHqyjdQ=; b=DsbYfxMN8wnSdz/MSHOweedJNq
 3sbaor7Tnalb1up3ONlCj+FmAZvIYq5QfiwVJW0+ZkMyUaT1KUfC/VnSVWuoWTvNbKaTBXAwhl39N
 AseHDY+y0EcXo0Rc3HvPVEqFoLRzlZKa0A65sVoR2RAgy+dMUpvps4VTQUiH1jQFKFEk=;
Received: from mail-pf1-f170.google.com ([209.85.210.170])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0CE4-0002Kz-T5 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 29 Aug 2026 06:07:37 +0000
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-854f8068301so1131375b3a.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 23:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787983651; x=1788588451; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GPuxmifIgDDwJZd/SBO1euENzZKqws9a+V2RPHqyjdQ=;
 b=CT+wIfpQVFxRq2a1n9KB1UaGfRvvL2YoEOsMsmp5eWppEOKBGQKvfwkeHpBpLQIJ9o
 8uKIg5bwxW99D0Qf8Tjktk27/I4Z1k9R3yhq/VIhelEWh0A2gCjZyYEzBCnlTsgaEnpo
 QtPFdLdBwt9AszqR5QzKXdXb5s2Hl/GNWzImMFIfbWood2TUWeBmbGTL0I2aTPV5ScIb
 3tp+xZh2omnNWR/7S0Kc+cpKEroUyu7iUBU7A0NXFwn7Q5EGKvjJkXYiW5+TlQgkODVw
 7SvU1fHVy/jtDeQX2sG6/jtpzqbFAbDzx3aVY4V8YhNVTPJvwPtzPFGADC8vLEMn0tHR
 vYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787983651; x=1788588451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GPuxmifIgDDwJZd/SBO1euENzZKqws9a+V2RPHqyjdQ=;
 b=U2IVkg/6Rg2aymsL0M+mfkBB/cdiwUkyssA5kqtyu+lJoZvsVmbrABkicGlVEToxfs
 oCX661iyKWKhka4W6SJSKSh/APW0ne8xCVRe3CAtqwWPB/eA6REhVOUhg5Y0vYdb6uQS
 x9H+R50rJKZmHzDyn6JCLPuZnNmtzCWCNbz3fV7vkInZYa9cS7UI3DhR92WABBwt0/qu
 y2ArXdUu70/eWCfu0rCQEvSzG2wEUgA2GI/c7sY5TqR4nMfPECiMoM0YAVoCDHdNxtdw
 9ROeu/awOOPaAgoIH6P9FaYRMimBj0PJ3EQw7yI9k5Qq/GI8DNqDXcZ1OPYzEulINbkl
 1OUw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqUkr0eyN/bt0EJCURdk+WikRyK5/pRaURkv6NKjRXrv5ImSUgw4SjOmNMbbB/kKRa9zWMFWQolEwv6nm5nDMO/@lists.sourceforge.net
X-Gm-Message-State: AFuF++kwnS+z+wxEiKXojrE4fr4PZiERDwmAoEbDmXERgOJ1e+sz1XHZ
 puAPpyUpHR3bzxSm+aZoDUPQZubb5nAuR5jjsz6M5I2B3FnouXPK2tky
X-Gm-Gg: AR+sD11GuAgWlFtyw6SmMls+NEO8fmdjuDHzPfZElzWf+OXrZYsE2/F75kfvO4WLdJF
 WhTtsNwAuqKYIve7Qp59lYxrgxcbaTXw4G2wfleewssDCHMcBY4CgjMjY/qgfAVCa9RO/AapPuF
 KTaQUkv8c7lnfgTLB9bmZDjxAh3CnvFsuHMpuHUWwyu/Y/erfIvyzDciMf0znlshcNHnItyhqV8
 c6AMxBOiYAPrAzhf0y6Efx37r3yFSq6kHaSzxgohm1iPdo47BtxLkj1/NZU3aCQE6yQrcKWLFEz
 OLV8sfSIRpdJzRdjLZOwCELssuOS709KkZQZ1RXejkwT0UEL0HGliGejHz6cEECOLc9XOGR+glO
 6KWFnR5MJ0Ww4NwQVJQtqwyWH2h3DXxO2F9WgSG65mQqyDSj0/F6yiKFuTSa/q7Z+qleHZlFmZw
 YGqmHHvSp/FlVbvzycJYD84P8PjQl7/sas4FuOAHMAc7no023WN5j5ue1w63rhYY8xwJVNslP/X
 h/L6M6rSjSYlWXk+lDmym6S
X-Received: by 2002:a05:6a00:3692:b0:848:5f4f:289d with SMTP id
 d2e1a72fcca58-856277dba33mr24011291b3a.4.1787983651209; 
 Fri, 28 Aug 2026 23:07:31 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-856a2ea6fbbsm1230035b3a.38.2026.08.28.23.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 23:07:30 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: daeho43@gmail.com
Date: Sat, 29 Aug 2026 14:07:24 +0800
Message-ID: <20260829060724.2657266-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CACOAw_x47vsdmPnYD1seCRjXMktocfcbAjPk7RMQEoPPJHLNiA@mail.gmail.com>
References: <20260828141240.2391915-1-qiwenjie@xiaomi.com>
 <20260828141240.2391915-2-qiwenjie@xiaomi.com>
 <CACOAw_x47vsdmPnYD1seCRjXMktocfcbAjPk7RMQEoPPJHLNiA@mail.gmail.com>
MIME-Version: 1.0
X-Headers-End: 1x0CE4-0002Kz-T5
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: refresh pinned allocation boundary
 after resize
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
Cc: daehojeong@google.com, qwjhust@gmail.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 jaegeuk@kernel.org, sunqiuyang@huawei.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Daeho,

I incorporated the review in v2:

- Simplified the incompatible-tail condition.
- Added an error message with the main, shrink, and tail section counts.
- Moved the check before mnt_want_write_file().
- Restored the compact formatting in the shared boundary helper.
- Added a post-freeze recheck for a concurrent remount option change.

The complete v2 series was sent separately.

Thanks,
Wenjie


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
