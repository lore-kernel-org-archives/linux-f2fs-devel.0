Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE9B606A6D5
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QTT2fX6w;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lT9GA+H+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=byAR1mPs;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=opcrbp9X;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=XRsQUKia
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:In-Reply-To:References:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=DIDq6kHxbK5yWBD2W5+c/LaINqpA++q9K4imAWXTP+I=; b=QTT2fX6wYOFrJ7L1RHxovY4YaZ
	DAkYv0jYNr5yhxYSNkeOLR3OfgYl7oT2cokp0p0kZDXTYHr3ZIpHGnG06AXC3u3FJaO8vIFJ7wAl2
	6m2xHyXJOVjlGaj04HQKx+W6KFU/Yl2WPAvVBb+57kC1JE4+O57uGzD8l4TArR7xsuW4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUUCU-000000003A4-2KWj;
	Fri, 20 Nov 2026 19:23:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <tz2294@columbia.edu>) id 1xUUCT-0000000039i-3aNe
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:23:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vIDPL8AZ7eMGzjcs6zTxktXgG5P+kytne5SeL3HgjYY=; b=lT9GA+H+1bdWdlrZ+GIKMuZgo/
 YRqbrxJ0tNTRYvjT+FnKY47yOeX/YiKjW9i37A4KIjabFzQIwCOuVBeITFKxFlIThXP3FviO5gPoG
 mddVQtEdZL7Zho5TMCret+dwwxnZxfZsHdwH82lOAuqYRzD3KDkT6b4/wasjJ1xlAMTU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vIDPL8AZ7eMGzjcs6zTxktXgG5P+kytne5SeL3HgjYY=; b=byAR1mPshyDGf2KokkyFkpCBmM
 A3apo/4dK482gq9NUnsrLYE0LV8vkHslbuzHTeTjyz1b3AWUXUzsE4pBEbdT2iXgP3ihfLQasxX5C
 ofD5OAeOp3wvq21K3w0rK3tYpPBisEkB1wMK83p7KM5Tm3VmLFUrMxb7xL5rU1GlRRcA=;
Received: from mx0a-00364e01.pphosted.com ([148.163.135.74])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUUCT-000000007EG-1dsa
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:23:09 +0000
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
 by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKIutnQ3639131
 for <linux-f2fs-devel@lists.sourceforge.net>; Fri, 20 Nov 2026 14:23:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=vIDP
 L8AZ7eMGzjcs6zTxktXgG5P+kytne5SeL3HgjYY=; b=opcrbp9XZsGYEIwv2DG3
 S5Xf6z1OgovgwSVWkjh7CekGu1j9SQr2ZQneiq4MIfzjWGaGHRPHbEB+PnpssCTH
 wK3XFkUmfhuWj/8QLeyXw93KaYAoBHxvJ4Tv7RmwMQrIv9udZ6sVXYDPJl8vFOQ6
 lmpfKd7DDuKRlfqruE1xgkWDzhLu/WeKde5TCOhC4pTTXHQORfgZVuhv7AqbeOE3
 yDo3XzNuE4+8rrPTztuVSAdBbUBR8w8zVkV19IEsn0UsE7/rUDsH9c56cCMq8BJx
 UBqy4pNg1T8UDayVvC0Am1PB12PURqRznB2x85vgu2POClUpbnzSkJO84f+3H04K
 OA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4j2rrn261y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 14:23:03 -0500 (EST)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91b937ecbb4so25294576d6.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 11:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1795202583; x=1795807383;
 darn=lists.sourceforge.net; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vIDPL8AZ7eMGzjcs6zTxktXgG5P+kytne5SeL3HgjYY=;
 b=XRsQUKiaTtvndpOhu4H8CgE88SQN+wqMaHFGhD6iOa+HoXnfToFPc/iV4CgXRX13hq
 kwIRCPH8npY86o6am0B09b9uXw0U/+NVgoYMBBy8rf4WJvk4Em5q3ce9Ya10veSVrziJ
 IcXm/BcMcEzWPocAB8XQfEJoBX0OMYs/RonFgCHML6VrZKpW39DO9MG8L5OHYb3I9i2f
 aO8peKoYnn3NijA+iXeY8MJkj4voKWlY8Jm/dT4s/b3JkFXHdSAcR9qaM2oHh6LJqE67
 WGcgOdE0EpLiHVxxxn0TzhlksV4Tmcjj/veAKDaLny1pA+bdLO955eHrx+UhDH4CC43p
 Od1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202583; x=1795807383;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vIDPL8AZ7eMGzjcs6zTxktXgG5P+kytne5SeL3HgjYY=;
 b=0S1H+Pb33PUTRpk3t+HfZNDrNUX3fgQye23cR2jG2+D4AM8jku+sRKc4DdNByaq3wd
 y/lrcQcyBJUEm2UXxYGUNJPCu95Vph6XjMp+mO+RCbtE42FGrFjWKTZtkovyjyPSFWrJ
 rLJ1eTVRF0Av0AsriCtXv2zbgjZkBx/+ErzLPBUQheBJrrJ7aSeBWSk1W764eNMaqqRF
 MsB9vrA5P776zlRbwAK4WMsXYpWsb9Yn5sMCz3kKfc1TzH8+gkZqlU/Scwjta7qk1IaG
 peaZROgssS4MrUhjatOk4U8nJ6D57Vl91UfDk8hhcj+blRPXLxKyvfMc/IFKrT1v+gA/
 vquQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHWEWHMRejs/BrZwCm5GPv4/YHN+sOgGqwbN3cupKO1fxMsBEwvBUtB+5uY2XWA07mKWtgdU/DqD/UrDHI8eo/K@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+5YS8Q2ZPCqpunAhpdK6ttqGoKvkOf3o2B54uZba1D4lFpxDgx
 egpAL1yz6YndeOUu/12rn8Huz53ZIOAs3tIE0wC16Irc8kGZs+8hDth07CTFPko6WtvEoBoXT50
 WUCaABsHDVQZY0isltPxq2wC1vSCIv85AMcMnmAJTITU/otlepoYPBrE4QPyWT6YnPC+6L0PRBI
 k=
X-Gm-Gg: AZFdTZc9oH+r/N23fLKDhVwyo6e/bbLVWuaxFuGsWO6Sa5jrQNgZxzWAPErcfc1Snc4
 mX8Vp/g6cVGTaWX6F3LD3LlTsomX60pGE1r3d/6p+c/HZGu+e5F2njXcpZLx9+5ooaYQKUmD5Wo
 9tb8wrayVwdvRW4b8a9DNGs5YmkWwJOou2DRSGfaPu076Egrkw06+Z8PVB9diLvyvysQICoO7YP
 GaIMmaDNUPQSkzfi1MGermDpOogduwlisu93LQON0Pmhvqj0cxmLM++6FTPNDxQlJmMmFwTJJOH
 p7qrkmOWldPaTCaSEuBJx2pQhwUZNhAlrlXgDelIX4q1U898NDu33xYqsXOrNJjvrlwMPAMF4C8
 WMePHjdDGPlGKQ5lz4BLl6kI+bIVoEoqOwYVakN19qkAoKok19d1xxKRESH76ojM8a5ntei5nJH
 9bN7RjR1w+49/4UHtVyqv7
X-Received: by 2002:a05:6214:6012:b0:921:2569:3a61 with SMTP id
 6a1803df08f44-92134ab82b1mr55734286d6.10.1795202582957; 
 Fri, 20 Nov 2026 11:23:02 -0800 (PST)
X-Received: by 2002:a05:6214:6012:b0:921:2569:3a61 with SMTP id
 6a1803df08f44-92134ab82b1mr55733996d6.10.1795202582549; 
 Fri, 20 Nov 2026 11:23:02 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-178-217.net.columbia.edu.
 [128.59.178.217]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm33337636d6.34.2026.11.20.11.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 11:23:01 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 20 Nov 2026 14:22:22 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261120-f2fs-fio-folio-v1-19-c21f94f82279@columbia.edu>
References: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
In-Reply-To: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202560; l=942;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=i2mltGLekAaBLtNPKD8Zl4grDK3w2ftaoYcYGfLqoD8=;
 b=zcfo6NUSAUp1saTSLmQnVnx63XCuY5Dh2PSb+0Ww8bEdU6lsspF+DaBKKVLf9A7zySHKpc66Z
 TpnotAkGKrgBvFv+4WZTBcW+4XMxMbbJdwAbQcvQ/BCKV8nqzVehQU3
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX7fEr+uU9gAkb
 Uss5h3n/JohPh8ETOKb7+jzfCSGy0Eb2EShjuM3wp3WU5q8D4hW7R54Po7MFc8lXNN2kIoy17wE
 RVH+0TEbjQva8jxl2zqeR6ogBcRItFPMrI86Bg8nrqzFc8diXyHVmILrlTn4ifjrr4d3fldPOJQ
 DWr+hKl0N22rofYyojG8JSX5zmyoJ+1qayAePu0SjcpH/YlclFjpZ1nSwH4uOfcgKGMoxqPIthd
 0JCVMjU8KU/BR8wwykOZIC95bKjTXryHQwXvaMugmwL2fX6jesHlnw7V3VDNvV1pthtxPXq0/ge
 FxBiwMATGXLiGHTmNGSEvm5jFDs5Olm4+cO7PI2ETOqqyfQc/7aeZqOB/ZwO8tCHkqpmLb9Aovj
 hrcdSG8xR+sFQ7X/KImk+pUsuJ/gfZwABAqEZJ5fP0A6HyhW1cxHQR/CYLG6z6stW07tjhndJGf
 BuCto6DHAwKeAABPnXw==
X-Authority-Analysis: v=2.4 cv=C498WgP+ c=1 sm=1 tr=0 ts=6b009e17 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=lnglQuR7XRqnmjDHco/WZg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=J7YxJo-oUBwfknBFKF8A:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: a8wqf1Jy_okrY6nvaN6nO9WMBSddTC9m
X-Proofpoint-GUID: a8wqf1Jy_okrY6nvaN6nO9WMBSddTC9m
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfX/P0YpHW6hqk8
 LjfL5dXb31tzIjE3aWvC9T/ZjIwaV8ufoLTj9Nd0ja1X5aR+y2RU0tjseBhd4rNtT6/fNVyyZhu
 JJMppINAZydVrF8t+aoePMAnG2kjJjoUliYIkd16WnBjs3o1feAF
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11972
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=10 bulkscore=10 adultscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 impostorscore=10 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200076
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUUCT-000000007EG-1dsa
Subject: [f2fs-dev] [PATCH 19/28] f2fs: convert f2fs_prepare_decomp_mem() to
 rfolios
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

Read the cluster folios through rfolios. tpages still holds pages, so
a cluster folio goes into it through folio_page(). This saves a hidden
call to compound_head().

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/f2fs/compress.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index bd76c59d91b2..b2622a51326f 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1862,9 +1862,8 @@ static int f2fs_prepare_decomp_mem(struct decompress_io_ctx *dic,
 		 * partial truncate). Decompress it into a bounce page instead,
 		 * see f2fs_decompress_cluster().
 		 */
-		if (dic->rpages[i] &&
-		    !f2fs_folio_has_ffs(page_folio(dic->rpages[i]))) {
-			dic->tpages[i] = dic->rpages[i];
+		if (dic->rfolios[i] && !f2fs_folio_has_ffs(dic->rfolios[i])) {
+			dic->tpages[i] = folio_page(dic->rfolios[i], 0);
 			continue;
 		}
 

-- 
2.39.5



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
