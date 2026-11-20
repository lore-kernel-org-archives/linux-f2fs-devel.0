Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE845606A33F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RHPX9ZZD;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FaYol42q;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HRXCwucO;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=S9JKnMp0;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=RGyCPWJl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:In-Reply-To:References:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=yVrb29w+u83sCzu6/eC94zLtPSHqWYtlrpg+3TMhjzE=; b=RHPX9ZZD4LDevd1YJC3GLj5gKg
	/Bhwe57UVb1hpwhexy4gZQx+KMlokqKQWyns2yB4bj1GMcilHLUtua/ZqFpoD0d6owjF5ZR+vi35U
	gfiw6A2DzZqcW0uB0+fkL2/zLWI0lEsbafAKlMjk36UegeiPGrXOOX01F6RQimJqGLkI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUUCF-000000004aq-2uSD;
	Fri, 20 Nov 2026 19:22:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <tz2294@columbia.edu>) id 1xUUCE-000000004ah-2rml
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:22:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4/NC3ZhGrMC8uHIvyq4ITYWgHflNoudqXwKqtUk3vOk=; b=FaYol42qD9AeeIIOOE8ufwLC9l
 yAnJbKv3ibfsXej/2bFrI3CD2x3vq11dz2AyS9z1YjSjn1nAhioHHMgYaiQhxFaQjBHss5bwTMLqH
 rTcWbeNbp3UOWanR+kY4S1l1zfqZ84cZUCpJnEQjhneBGlCCqRWOotRd1/m+/r0CdqGs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4/NC3ZhGrMC8uHIvyq4ITYWgHflNoudqXwKqtUk3vOk=; b=HRXCwucOQu9+U9m5KexdX4MOjX
 1Pf5a3tiqkGAUmmSle/tL7ExT/HeD3/1VqinCy60I5c+I46USO5+aOAUXXhrF/1g2+d548ZPcuaOX
 pOOpFYseRLlOOEyyvV5TQLDA8wTnRj7q+rTChQzdmWp2+XeIoMmGnsh7p9ejeT0ABJT0=;
Received: from mx0b-00364e01.pphosted.com ([148.163.139.74])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUUCE-0000000017H-0JUq
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:22:54 +0000
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
 by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKIukmg3421088
 for <linux-f2fs-devel@lists.sourceforge.net>; Fri, 20 Nov 2026 14:22:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=4/NC
 3ZhGrMC8uHIvyq4ITYWgHflNoudqXwKqtUk3vOk=; b=S9JKnMp0m342TPdU1D1f
 GeGEmsCbfjE0pXm9gIkpneXRp765K65//wV+S0faMcuvv7hw+o4yEjQOuQz/ij+k
 I/rsppYEhb12urxAe3fZj2BjZc9sQ39UAlOOZisdA1/oO3+Ei5HX3jdDRLH8yx9E
 BT00yCsErrwz9pQXC8KC+l22P22QYSmcHyo0+S5/xB0MRx4gBjPo7yEbat+OBBnD
 X3PM6MCUmLbUIwrd3IxBPlnJJTPFCq4bGDaNP49PMa2cam0VFfQske8Gu/ChVV9v
 lFWMN2utlpWMEx2N5spjpXVMXtqFuBiSK+bqMPeG4+f6Qi11TUzVucoW0glqNkie
 mQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j2rym20ra-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 14:22:48 -0500 (EST)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-9213c7a506fso14911286d6.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 11:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1795202567; x=1795807367;
 darn=lists.sourceforge.net; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4/NC3ZhGrMC8uHIvyq4ITYWgHflNoudqXwKqtUk3vOk=;
 b=RGyCPWJl0xO/TLlZByJdlvkoJVMp3QZQ2z/LcOvFk3eJRkZusxXQILdoSTIXIDGgwC
 wQhXG8KYn44vhbM80Pi97lyJfVnColjXK8XBVR5iNFof4mB4xUm2L4CGUwn5RkFCHMT6
 75ptmOfH3nwfte0xlW3x6qT2syJJEHvubpwUxpCUH9n7x7jDLMW/QxaP4FgMLJo4Gp5r
 DwcHp0bC28sRZ9vM9QGqzui/jeSWK9dt4AlMc+SHcNdziR3hAQn1ZCzZwR/egen6/lTg
 46ITAvDskORGIyM9tVSux8bPsSkyoHWzCFBfLdWnuOmK6y7paiprrR7ChoT+1qzezWN1
 iJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202567; x=1795807367;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4/NC3ZhGrMC8uHIvyq4ITYWgHflNoudqXwKqtUk3vOk=;
 b=nDgEFmoh0kIk7oz/dcRm+aUSSZhEwMEkRrJRSTRu2ohAR9DP+TxEGC63aASv9KUP9h
 ogyf5gRgjfLQR8V0I+rAv65i7M4HBjCY1Utu6vcnaXqZxfmPctKjsVb6q97mNMiSvPno
 nYDJiJ6eZcyOhoJynHNB2CfE8HHupAFxhp24rkuwfd3n/cEPHcsbmFZ1e74Y/ZtxsLCz
 bdwt1mosHgby7WBFPkLxcsj3Py/X1/qYCAxhCVqyuwj4NhGi6CS0aFPAxCBTwmMFnLvV
 Gd55pZ3ThoKbUeaFQNaOwM/kVqCX+YFwpRJ4i9ei/HaJGk8xYZEwmKfFu1OFnumzoR3m
 o4DA==
X-Forwarded-Encrypted: i=1;
 AL+hErFq40Nuv9Vkp0BKXR8DhJ9CwXu/Q7l77ryjJp5zAUphek94/qXx2Hy/MXpgCTzADyCqgakhgGGMshkjsghTw92a@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8sdVh/74BvdPXK5JnXu5jtsXj2TnDsk/3LMtfwqYDZwC2/Wc1U
 ja4OhBtvCHEKy3cFDCI4kqNUuMu0is3RekWaC42u3YKpcU7/uB5CDSznez6j/9Hb07ccOEGHCsk
 hiBAVoXxyWU27TO6Huj5bEEzwpi6l5Fo9x7o+jxq+8Y9Xm8LmYL+x+kHtiNTWuwomhBA70ZRUyv
 jVBr+haKg=
X-Gm-Gg: AZFdTZcsZLu4DDD5iUWS4Qxf8H+83ojk9LCfBAPzb0ixWvQ5Fel6C3wJB2ErwGx3omH
 DhKV7ImazWL0E2w1dTwgnmfUqE5X3IVSNMxVhIfrwlGuVBOMyKDNpcgsY83F8R4NLKkZDjJZ+3c
 xUplamyviMjvixGe6TqANa5JxGhRIyXN/0IEAqentpQdFw53+eOmB5CgTKGGlRjDMsX7GovwdoJ
 vcu0eT8xcX1NtFXZ60QziYJVlz1hBOw5NblW7Eidd+5nn2RkQftB1i35rH3WOkScCpqk2Xf+YKa
 TpzM6dSzjVehXY8NDPJYcrNu0Cblp+hJT3gxrQyh0l/gm99W/JVVjoTtwPq/a+KHz8n0+IkWEuW
 HoWDociIwBCIyojtvHM3WJnI893LjwTAcwGp2flDf89gIOdy5yBBFCgzzAqXt8tPjHQwgA9lJjf
 LXxQcoYPGhHwjYd7TbMQKU
X-Received: by 2002:a05:6214:20e2:b0:921:2dc1:bb6a with SMTP id
 6a1803df08f44-92134a37025mr69139036d6.20.1795202567656; 
 Fri, 20 Nov 2026 11:22:47 -0800 (PST)
X-Received: by 2002:a05:6214:20e2:b0:921:2dc1:bb6a with SMTP id
 6a1803df08f44-92134a37025mr69138686d6.20.1795202567175; 
 Fri, 20 Nov 2026 11:22:47 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-178-217.net.columbia.edu.
 [128.59.178.217]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm33337636d6.34.2026.11.20.11.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 11:22:46 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 20 Nov 2026 14:22:08 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261120-f2fs-fio-folio-v1-5-c21f94f82279@columbia.edu>
References: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
In-Reply-To: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202560; l=1396;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=aQN3O18uO7yFCNGBwmNXQ9uh6n7E0Jp9HsNDYOQC2dg=;
 b=y1reXWzdQpyS6QiOh90bEp5yI5I0EDxUCt0xRTarm4Rta/0nIEC8fnbw28I8OVJWX2oy5z7qm
 HFv82BAYqSuCSpHi697BrxTzwo6dlWz7ZHuPSFYcdRNyy7O5Py6f1FQ
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfXxkbof5g+TKg8
 lOXUmzkkZ8llkr6npa1cUZ/I1/A1Odk8Sq9c06yyxKU9kqP+IGD7Iwn6+M1myGz/nk9bNeNE61H
 KjEqWMr1c+ESpl9ecpvrJj8rEO2jWbm8ZRVkZSLc9Y5gb2aNVliy+SF7iXiZtM3P0Du0Hi3RZxd
 kbepmMd+2SFOMR48xuwQyFsGgL7Zd16pl3Bnc4/2ait9+xS3aDE2RsGpCNIQIB3uQqVkgMRKUAG
 3f1PIhLh+L6r6v3yFP7/KfOz3rYQMJDWl8fvlKzga3tUkX8EabzjmQ6dCA+Z5RbTkROTSE1aoYX
 sH1I+U90GJpHhY0XnrpXtJaUy1WCPEU7SEFKKvdixQElkp6iTLPtWvuBu//xfBrGdmyeRSZUa/p
 Lricos8maAkU/9hGp7Wwx+qkG0Hzm1NumgOlVr+sKDdYIERnBnEq78BjVY7v18HEc2/mKv/TBL4
 hZXamKfIinOd6XAyvEA==
X-Authority-Analysis: v=2.4 cv=CZydd7rl c=1 sm=1 tr=0 ts=6b009e08 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=lnglQuR7XRqnmjDHco/WZg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=wZKBvBEY84YxQXbPgYcA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfXwgXvUI9JlYAr
 fMhVscjpTEPezgwbvNRjUjoFJzMcZH3XD0uNd9zrOdJoSnYXPYc8D+vc4KSEnj2V4XlUPgsEH5+
 F0hekJWmReSKggK5y+NfHmpmfBY021GbbO6amaNbQ2F0jFamOR8m
X-Proofpoint-ORIG-GUID: klUfidd_MOYViy1-MaZ71_VnR0cokfxE
X-Proofpoint-GUID: klUfidd_MOYViy1-MaZ71_VnR0cokfxE
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11972
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=10 bulkscore=10 suspectscore=0
 lowpriorityscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200076
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUUCE-0000000017H-0JUq
Subject: [f2fs-dev] [PATCH 05/28] f2fs: remove compressed_page from struct
 f2fs_io_info
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Tal Zussman <tz2294@columbia.edu>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Nothing uses fio->compressed_page anymore. Drop it from the union,
leaving only fio->compressed_folio.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/f2fs/compress.c | 2 +-
 fs/f2fs/f2fs.h     | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 7fb46aab2cb6..dfa78f5268a6 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1438,7 +1438,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 		.old_blkaddr = NEW_ADDR,
 		.folio = NULL,
 		.folio_blkcnt = 1,
-		.compressed_page = NULL,
+		.compressed_folio = NULL,
 		.io_type = io_type,
 		.io_wbc = wbc,
 	};
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c365e8715108..1090bcf1c776 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1353,10 +1353,7 @@ struct f2fs_io_info {
 	struct folio *folio;	/* folio to be written */
 	pgoff_t folio_offset;	/* offset in large folio */
 	unsigned int folio_blkcnt;	/* block count in large folio */
-	union {
-		struct page *compressed_page;	/* compressed page */
-		struct folio *compressed_folio;
-	};
+	struct folio *compressed_folio;	/* compressed folio */
 	struct list_head list;		/* serialize IOs */
 	unsigned int compr_blocks;	/* # of compressed block addresses */
 	unsigned int need_lock:8;	/* indicate we need to lock cp_rwsem */

-- 
2.39.5



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
