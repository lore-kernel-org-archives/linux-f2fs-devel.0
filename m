From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: add new idle interval timing for
 discard and gc paths
Date: Wed, 19 Sep 2018 21:05:34 +0800
Message-ID: <ffa10ee8-c629-aac5-ffbb-6bb6bb24b7f3@kernel.org>
References: <1537346927-9649-1-git-send-email-stummala@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537346927-9649-1-git-send-email-stummala@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sahitya Tummala <stummala@codeaurora.org>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2018/9/19 16:48, Sahitya Tummala wrote:
> This helps to control the frequency of submission of discard and
> GC requests independently, based on the need.
> 
> Suggested-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
