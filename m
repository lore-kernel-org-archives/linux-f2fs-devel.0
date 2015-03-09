From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 1/3 v2] f2fs:remove unnecessary condition
 judgment
Date: Mon, 09 Mar 2015 14:46:53 +0800
Message-ID: <000001d05a34$fb2157d0$f1640770$@samsung.com>
References: <1261310236.1196121425869030109.JavaMail.weblogic@epmlwas01c>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1261310236.1196121425869030109.JavaMail.weblogic@epmlwas01c>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: yuan.mark.zhong@samsung.com, 'Jaegeuk Kim' <jaegeuk@kernel.org>, '???' <cm224.lee@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

> -----Original Message-----
> From: Yuan Zhong [mailto:yuan.mark.zhong@samsung.com]
> Sent: Monday, March 09, 2015 10:44 AM
> To: Jaegeuk Kim; ???
> Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] [PATCH 1/3 v2] f2fs:remove unnecessary condition judgment
> 
> Remove the unnecessary condition judgment, because
> 'max_slots' has been initialized to '0' at the beginging
> of the function, as following:
> if (max_slots)
>        *max_slots = 0;
> 
> Signed-off-by: Yuan Zhong <yuan.mark.zhong@samsung.com>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>

