From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 3/4] f2fs: indicate shutdown f2fs to allow
 unmount successfully
Date: Mon, 9 Jul 2018 22:42:14 +0800
Message-ID: <2bdae76c-abce-b9b5-512e-d1354589b369@kernel.org>
References: <20180706210903.77887-1-jaegeuk@kernel.org>
 <20180706210903.77887-3-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180706210903.77887-3-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/7/7 5:09, Jaegeuk Kim wrote:
> Once we shutdown f2fs, we have to flush stale pages in order to unmount
> the system. In order to make stable, we need to stop fault injection as well.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
