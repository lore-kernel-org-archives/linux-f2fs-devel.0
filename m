From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v2] f2fs: handle newly created page when revoking inmem
 pages
Date: Thu, 11 Jan 2018 17:55:21 +0800
Message-ID: <aa03f7b9-f694-3d2d-1465-0c0bb89b0367@huawei.com>
References: <CGME20180111001658epcas1p1e4a99f89bf1fabab2c22f46f939e3403@epcas1p1.samsung.com>
 <1515629837-6735-1-git-send-email-daeho.jeong@samsung.com>
 <33e722cc-d944-1587-8b39-42a117e04b73@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <33e722cc-d944-1587-8b39-42a117e04b73@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>, Daeho Jeong <daeho.jeong@samsung.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: heyunlei@huawei.com, Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/1/11 14:50, Yunlong Song wrote:
> Should it be "When committing inmem pages is not successful" ?

I guess Daeho want to say "Partially successful"?

Thanks,
