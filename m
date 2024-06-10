Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6401C27C5E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 10 Jun 2024 03:17:07 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sGVWs-0006Mw-22;
	Mon, 10 Jun 2024 03:17:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daejun7.park@samsung.com>) id 1sGVWp-0006Mp-Uf
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Jun 2024 03:17:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:Content-Type:Content-Transfer-Encoding:
 Date:Message-ID:In-Reply-To:CC:To:From:Sender:Reply-To:Subject:Mime-Version:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QicgXxIlqpC31U/1Nxw3Hsoz4A8pKQPVMlH3jzLsGNQ=; b=QdvYQuk9XDIPeDhQ1Yo+BR33Mo
 +HBRSgEGX/IRtTyG4Eok0fC1u3GfB1q9TQewyUr9XQli1lp3X3X5GxD1i/okYXyBgCWuFPVwqtzcC
 8uoVXXGsj4XE5zgH2NF/hIAluHpL7V1AbE7cqNMzo7IfHXiG5Iv1i5rXyG92CelB9Z50=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:Content-Type:Content-Transfer-Encoding:Date:Message-ID:
 In-Reply-To:CC:To:From:Sender:Reply-To:Subject:Mime-Version:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QicgXxIlqpC31U/1Nxw3Hsoz4A8pKQPVMlH3jzLsGNQ=; b=UV77fxVSEa7bi6piDVpMCtM+CJ
 aefIBPLPAlAvciph8poYaueG4qQa7tWZ3LgJmiASc+FcOxuK9hEWe0aqgZM18T+B40r1rljgUy5MG
 zDWI2wDyoIi7QSVSOiv3i+QNBrBl0hIVWwg0Ji1IeEfJDGt7YnG7eRaRbp8QTThTh17o=;
Received: from mailout3.samsung.com ([203.254.224.33])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sGVWo-0004N9-Fq for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Jun 2024 03:17:03 +0000
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20240610031649epoutp034db881ffbfac47f9ed35d05b1746244a~XhkP9E5x32625626256epoutp03g
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 10 Jun 2024 03:16:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20240610031649epoutp034db881ffbfac47f9ed35d05b1746244a~XhkP9E5x32625626256epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1717989409;
 bh=QicgXxIlqpC31U/1Nxw3Hsoz4A8pKQPVMlH3jzLsGNQ=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=QzY4ppZgLQe+Ud8Am3tA80rkyoJs0DUQ2HTCOTMcxXtgOPGF69urkCgLLig/Dte5v
 +mxMEaHRZPWP16afaQvVyyweS9qJUu5VQ2czGCZadaAmREoPmeVqoMEoITJKLUtifO
 QZlhcqoKiEttw+K8eaxe0AmzwvkDMRjacp/DKRvU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20240610031648epcas2p4a08c957de2fbac2dd1b135cf86d8c2c1~XhkPfYPTT2295422954epcas2p4_;
 Mon, 10 Jun 2024 03:16:48 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.102]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4VyH5r452Pz4x9Pt; Mon, 10 Jun
 2024 03:16:48 +0000 (GMT)
X-AuditID: b6c32a48-105fa70000002507-11-666670209a4c
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
 epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 28.E0.09479.02076666; Mon, 10 Jun 2024 12:16:48 +0900 (KST)
Mime-Version: 1.0
From: Daejun Park <daejun7.park@samsung.com>
To: Yongpeng Yang <yangyongpeng1@oppo.com>, "jaegeuk@kernel.org"
 <jaegeuk@kernel.org>, "chao@kernel.org" <chao@kernel.org>, "corbet@lwn.net"
 <corbet@lwn.net>, "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <0db07a4a-91da-402e-9601-46b196b8cf1b@oppo.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240610031547epcms2p526560bc9d2fd3a5f36615fe645640079@epcms2p5>
Date: Mon, 10 Jun 2024 12:15:47 +0900
X-CMS-MailID: 20240610031547epcms2p526560bc9d2fd3a5f36615fe645640079
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmha5CQVqaQUurrMXpqWeZLJ4caGe0
 eHlI02LVg3CLHydNLJ6sn8VssbBtCYvFpUXuFpd3zWGzaPnjZHF+4msmi1UdcxktFk36zebA
 67FpVSebx+4Fn5k8FvdNZvV4N0vJo2/LKkaPz5vkAtiism0yUhNTUosUUvOS81My89JtlbyD
 453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgG5UUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQX
 l9gqpRak5BSYF+gVJ+YWl+al6+WlllgZGhgYmQIVJmRnnGh7wF6wka1ixorHzA2M81i7GDk5
 JARMJHp3rWLpYuTiEBLYwSix+cIfpi5GDg5eAUGJvzuEQWqEBYIltr+ewAZiCwkoSay/OIsd
 Iq4ncevhGkYQm01AR2L6ifvsIHNEBD4xSZw58wFsKLPAUUaJL3ePM0Js45WY0f6UBcKWlti+
 fCtYnFPARqL/7xeoGg2JH8t6mSFsUYmbq9+yw9jvj82HqhGRaL13FqpGUOLBz91QcUmJ23M3
 QdXnS/y/shzKrpHYdmAelK0vca1jI9gNvAK+EhdPNTOB2CwCqhItJ44wQdS4SCx+sxCshllA
 XmL72znMoEBhFtCUWL9LH8SUEFCWOHILqoJPouPwX3aYDxs2/sbK3jHvCdR0NYl1P9czTWBU
 noUI6VlIds1C2LWAkXkVo1hqQXFuemqxUYEJPHKT83M3MYKTq5bHDsbZbz/oHWJk4mA8xCjB
 wawkwiuUkZwmxJuSWFmVWpQfX1Sak1p8iNEU6MuJzFKiyfnA9J5XEm9oYmlgYmZmaG5kamCu
 JM57r3VuipBAemJJanZqakFqEUwfEwenVAPTeofQPxEKE7Qyny5SfNmsl3990v/8zPdKJ66I
 mf/OT0pIO3rvwn2Jux/i/db+b6mo3GV05mzxpn8VMT27rIJFp2lO6gzcsrfSvihvStzcadkK
 lzz9A/UjX2hcPrD+2Aaf8gvdXXq/Pzsx+zdp7nafo7r6i5ta/8RV2w52L90nei3yqvz9heI7
 lvQ96jy8ZUniXc2PN48VLWS7sYTjWqJB4b62Xr8YD/WCjYYq3suPaFTezu3MO2zzuTLOd0Jw
 F9ez8JNGcr1GDs5Jn2Qm/mx9tISx8QejxALTrEMNXmfnOPKopwcyBeS/+ef3vaCP9UwKX8PJ
 yffCu1O8u9fvm3b8U7e58rnMEl65+48dGY2UWIozEg21mIuKEwFOJDN7NwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240531074640epcms2p46c3cf8b7cc4e707948ae200115e28e39
References: <0db07a4a-91da-402e-9601-46b196b8cf1b@oppo.com>
 <20240531074640epcms2p46c3cf8b7cc4e707948ae200115e28e39@epcms2p4>
 <CGME20240531074640epcms2p46c3cf8b7cc4e707948ae200115e28e39@epcms2p5>
X-Headers-End: 1sGVWo-0004N9-Fq
Subject: Re: [f2fs-dev] (2) [RFC PATCH] f2fs: add support single node
 section mode
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
Reply-To: daejun7.park@samsung.com
Cc: Seokhwan Kim <sukka.kim@samsung.com>, Nayeon Kim <nayeoni.kim@samsung.com>,
 Dongjin Kim <dongjin_.kim@samsung.com>, Siwoo Jung <siu.jung@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

> Hi Daejun,
> 1. It is not compatible with "F2FS_OPTION(sbi).active_logs == 2".
> 2. Once has_enough_free_secs is false, F2FS cannot restore to multi-node
> sections even after has_enough_free_secs becomes true and the filesystem
> is unmounted and remounted. This seems unreasonable.

Hi Yongpeng Yang,

1. Yes, I will modify it so that it only applies when active_log is 6.
2. This technique is effective when utilization is high. Therefore, in my scenario, I assumed that only heavy users would use this option. So I assumed that the free section would not be sufficiently secured even after that.
Futhermore, if a new section is allocated to deactivate a single node whenever there is free space, then soon again insufficient free space may occur, resulting in more unnecessary GC.

Thanks,
Daejun


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
